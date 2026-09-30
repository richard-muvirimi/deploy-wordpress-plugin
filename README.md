# Deploy WordPress plugin

Deploy WordPress Plugin to SVN repository

This action commits files to your SVN repository (totally unopinionated about how or when you do it). 

### Requirements

- An Ubuntu / Debian runner, e.g. `ubuntu-latest`. `subversion`, `rsync` and `zip` are installed with `apt`.

### Repository layout

The action deploys two folders, and nothing else:

```text
your-repository/
├── .wordpress-org/          ← assets-directory → SVN assets/
│   ├── banner-772x250.png
│   ├── banner-1544x500.png
│   ├── icon-128x128.png
│   ├── icon-256x256.png
│   └── screenshot-1.png
├── build/                   ← working-directory → SVN trunk/, tags/<version>/ and the zip
│   ├── my-plugin.php
│   ├── readme.txt
│   └── includes/
├── src/                     ┐
├── node_modules/            │ everything outside the two folders
├── tests/                   │ is never deployed
└── .git/                    ┘
```

- **Working directory**: everything in it is committed exactly as is, nothing is filtered out. Fill it with only the files that ship, e.g. in a build step before this action, and point `working-directory` at it. Left empty it defaults to the whole repository, including `.git/`, so set it unless your repository only contains the plugin.
- **`readme.txt`** belongs at the root of the working directory, its `Stable tag` is the default version.
- **Assets directory**: banners, icons and screenshots for the WordPress.org plugin page, see [plugin assets](https://developer.wordpress.org/plugins/wordpress-org/plugin-assets/) for file names and sizes. Keep it outside the working directory, if it is inside it is left out of `trunk/` and the zip automatically.

### Usage Example
```yml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Build
      run: |
        mkdir build
        cp -r my-plugin.php readme.txt includes build/
    - name: WordPress Plugin Deploy
      id: deploy
      uses: richard-muvirimi/deploy-wordpress-plugin@1.1.1
      with:
        svn-username: ${{ secrets.SVN_USERNAME }}
        svn-password: ${{ secrets.SVN_PASSWORD }}
        working-directory: build
```

#### Upload the plugin zip to a GitHub release

A zip of the working directory is also generated, laid out as WordPress expects: a single `<plugin-slug>/` folder at the root, so it can be installed from Plugins → Add New → Upload. Its path is available as the `plugin-zip` output, for example to attach it to the release that triggered the deploy.

```yml
on:
  release:
    types: [published]

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
    - uses: actions/checkout@v4
    - name: Build
      run: |
        mkdir build
        cp -r my-plugin.php readme.txt includes build/
    - name: WordPress Plugin Deploy
      id: deploy
      uses: richard-muvirimi/deploy-wordpress-plugin@1.1.1
      with:
        svn-username: ${{ secrets.SVN_USERNAME }}
        svn-password: ${{ secrets.SVN_PASSWORD }}
        working-directory: build
        plugin-version: tag
    - name: Upload release asset
      env:
        GH_TOKEN: ${{ github.token }}
        TAG: ${{ github.event.release.tag_name }}
        PLUGIN_ZIP: ${{ steps.deploy.outputs.plugin-zip }}
      run: gh release upload "$TAG" "$PLUGIN_ZIP"
```

### SVN tag generation

On each run the working directory is copied to `trunk/` and to `tags/<plugin-version>/`. An existing SVN tag with the same version is overwritten.

The deploy stops before anything is committed if the working directory does not exist or no version can be determined, e.g. `readme.txt` has no `Stable tag`, or `plugin-version: tag` runs on a branch push.

### Suggested workflows

1. On tag creation, with `plugin-version: tag` so the version is the pushed tag.
```yml
on:
  push:
    tags:
    - "*"
```
2. Having a production only branch where you merge to when ready. Version being picked from the `Stable tag` in `readme.txt` (default).
3. Any other [events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)

### Action Inputs

<table>
<thead>
<tr>
<th>Name</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>

<tr>
<td>
<code>svn-username</code>
</td>
<td>
SVN repository username.
</td>
<td>
required
</td>
</tr>

<tr>
<td>
<code>svn-password</code>
</td>
<td>
SVN repository password.
</td>
<td>
required
</td>
</tr>

<tr>
<td>
<code>plugin-repository</code>
</td>
<td>
The svn repository name (slug) of the plugin on WordPress.org. Can be a full url to use a custom repository. Defaults to git repository name if empty.
</td>
<td>
<code>''</code>
</td>
</tr>

<tr>
<td>
<code>plugin-zip</code>
</td>
<td>
Zip file name to generate, <code>slug</code> (default) to use the plugin slug, any other text to name it differently, empty to disable. <code>.zip</code> is appended automatically.
</td>
<td>
<code>'slug'</code>
</td>
</tr>

<tr>
<td>
<code>plugin-zip-folder</code>
</td>
<td>
Folder name to use at root of zip, <code>slug</code> (default) to use the plugin slug as WordPress expects, any other text to name it differently, empty for no folder.
</td>
<td>
<code>'slug'</code>
</td>
</tr>

<tr>
<td>
<code>plugin-version</code>
</td>
<td>
Tag for releasing to WordPress. <code>readme</code> (default) reads the <code>Stable tag</code> from <code>readme.txt</code> in the working directory root, <code>tag</code> uses the pushed git tag (fails on non tag pushes), any other text is used as is. The deploy fails if no version can be determined.
</td>
<td>
<code>'readme'</code>
</td>
</tr>

<tr>
<td>
<code>commit-message</code>
</td>
<td>
Commit message for releasing to WordPress, any custom text to use a custom message, <code>git</code> (default) to use the last git commit message. Substitutes every <code>:VERSION</code> with the provided/inferred plugin version.
</td>
<td>
<code>'git'</code>
</td>
</tr>

<tr>
<td>
<code>working-directory</code>
</td>
<td>
Working directory, defaults to <code>$GITHUB_WORKSPACE</code> if empty. All files in working directory will be committed, except those in the <code>assets-directory</code> directory. The deploy fails if it does not exist.
</td>
<td>
<code>''</code>
</td>
</tr>

<tr>
<td>
<code>assets-directory</code>
</td>
<td>
Directory containing plugin assets (banners, icons, screenshots), committed to the SVN <code>assets/</code> folder. Set empty to disable, skipped if it does not exist.
</td>
<td>
<code>'.wordpress-org'</code>
</td>
</tr>

</tbody>
</table>

### Action Outputs

<table>
<thead>
<tr>
<th>Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>

<tr>
<td>
<code>plugin-zip</code>
</td>
<td>
Path to generated plugin zip file, if <code>plugin-zip</code> was set.
</td>
</tr>

<tr>
<td>
<code>plugin-version</code>
</td>
<td>
The version tag used to commit to <code>plugin-repository</code>
</td>
</tr>

<tr>
<td>
<code>commit-message</code>
</td>
<td>
The message used to commit to <code>plugin-repository</code>
</td>
</tr>

</tbody>
</table>

### Road Map

1. Old tag cleanup
  - Keep latest version of previous minor versions, and all versions for the current version
  - Keep limited number of versions
  - Replicate github versions

### Contributing

Just make sure all [contributing guidelines](CONTRIBUTING.md) are met.

### License

```
MIT License

Copyright (c) 2022 Richard Muvirimi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
