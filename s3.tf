resource aws_s3_bucket "b1"{
   bucket = "hsbc-gowtham1998"
}
resource aws_s3_bucket_policy "bpolicy"{
   bucket = aws_s3_bucket.b1.bucket
   policy = file("./bpolicy.json")
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b1.id
  versioning_configuration {
    status = "Enabled"
  }
}