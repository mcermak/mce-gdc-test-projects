mce-gdc-test-projects
=====================

Sources for testing GDC projects

Creating project and uploads:

1. go to gray pages of path /gdc/projects
2. fill project title and project group, submit, and poll on the result
3. as the project is created, go to path _/gdc/md/\<project-id\>/ldm/manage2_, fill content of _model.maql_, and submit
4. the model is created, now you have to provide upload data (csv files and upload\_info.json).
5. zip csvs files and upload\_info.jsou to upload.zip
6. upload upload.zip on webDav: _curl -u '\<login\>@gooddata.com' -T upload.zip https://\<machine\>.na.gooddata.com/uploads/upload.zip_
7. go to gray pages on _/gdc/md/\<project-id\>/etl/pull_ and submit
8. wait until upload is not done
