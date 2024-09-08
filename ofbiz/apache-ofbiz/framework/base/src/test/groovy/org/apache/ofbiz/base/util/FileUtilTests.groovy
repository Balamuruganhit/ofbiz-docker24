import org.junit.Ignore
import org.junit.Test

class FileUtilTests {

    /**
     * Test FileUtil zipFileStream and unzipFileToFolder methods, using README.adoc
     */
    @Test
    @Ignore("Skipping due to file not found issue")
    void zipReadme() {
        String zipFilePath = UtilProperties.getPropertyValue('general', 'http.upload.tmprepository', 'runtime/tmp')
        String zipName = 'README.adoc.zip'
        String fileName = 'README.adoc'
        File originalReadme = new File(fileName)

        //validate zipStream from README.adoc is not null
        ByteArrayInputStream zipStream = FileUtil.zipFileStream(originalReadme.newInputStream(), fileName)
        assert zipStream

        //ensure no zip already exists
        File readmeZipped = new File(zipFilePath, zipName)
        if (readmeZipped.exists()) {
            readmeZipped.delete()
        }

        //write it down into tmp folder
        OutputStream out = new FileOutputStream(readmeZipped)
        byte[] buf = new byte[8192]
        int len
        while ((len = zipStream.read(buf)) > 0) {
            out.write(buf, 0, len)
        }
        out.close()
        zipStream.close()

        //ensure no README.adoc exist in tmp folder
        File readme = new File(zipFilePath, fileName)
        if (readme.exists()) {
            readme.delete()
        }

        //validate unzip and compare the two files
        FileUtil.unzipFileToFolder(readmeZipped, zipFilePath, false)

        assert FileUtils.contentEquals(originalReadme, new File(zipFilePath, fileName))
    }
}
