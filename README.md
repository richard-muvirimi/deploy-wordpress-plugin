# Deploy WordPress plugin

Deploy WordPress Plugin to SVN repository

This action commits files to your SVN repository (totally unopinionated about how or when you do it). 

### Usage Example
```yml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: WordPress Plugin Deploy
      id: deploy
      uses: richard-muvirimi/deploy-wordpress-plugin@development
      with:
        svn-username: ${{ secrets.SVN_USERNAME }}
        svn-password: ${{ secrets.SVN_PASSWORD }}
```

Optionally a zip file of the commited files can be generated and path provided incase you want to run further actions, for example 
#### Create a tag
```yml
 
 - name: Upload release asset
      uses: actions/upload-release-asset@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        upload_url: ${{ github.event.release.upload_url }}
        asset_path: ${{ steps.deploy.outputs.plugin-zip }}
        asset_name: ${{ github.event.repository.name }}.zip
        asset_content_type: application/zip
```

### Tag generation

Tags are created/updated on each run using provided `plugin-version` for the tag to target.

### Suggested workflows

1. On tag creation. Version will be picked from latest tag.
```yml
on:
  push:
    tags:
    - "*"
```
2. Having a production only branch where you merge to when ready. Version being picked from `readme.txt`.
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
The svn repository name (slug) of the plugin on WordPress.org. Can be a full url to use a custom repository. Defaults to git repository name if empty. Default empty.
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
Zip file name to generate, any custom text to name differently, "slug" (default) to use plugin slug, set empty to disable. <code>.zip</code> will be automatically appended.
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
Folder name to use at root of zip, "slug" to use plugin slug, set empty to disable.
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
Tag for releasing to WordPress, any custom text to use a custom tag, "tag" to read from release tags, "readme" (default) to obtain from readme.txt.
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
Commit message for releasing to WordPress, any custom text to use a custom message, "git" (default) to use the last git commit message. Substitutes <code>:VERSION</code> with provided/inferred plugin version.
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
Working directory, defaults to <code>$GITHUB_WORKSPACE</code> if empty. All files in working directory will be committed, except those in "assets-directory" directory. Default empty.
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
Directory containing plugin assets, defaults to <code>.wordpress-org</code>, set empty to disable.
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
