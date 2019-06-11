# bash-scripts
Bash script to batch extract page titles from TIFF headers with their filenames and put them as columns in a spreadsheet.
Requirements:  ExifTool; connection to NetApp
Once the scanning of the directory and reading of the image files have been completed, the final CSV will be complete 
with page filenames extracted from the source path of the image file and page titles extracted from the TIFF header. 
Page titles are prepended with "f." (which stands for 'folio'); these can be removed from front and back matter folia manually 
afterwards if necessary. This CSV may be uploaded on Google Drive or submitted to the Samvera team.
