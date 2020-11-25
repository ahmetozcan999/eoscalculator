import 'package:gsheets/gsheets.dart';

// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "eoscalculator",
  "private_key_id": "746c11fc5bfd2594f4a314fa1c98dd25ef647530",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCjdtp6AsH+Y10I\nhiRVEwXAct6uPmKk/njEYDQ0yypvUIgasN9c0nzxZi7yBwuh/mRCDpfZYeXKK5aG\nRNXssFdfe5LtrvM8S27oGj5sq/HJ9DhNLmwMcAs8+in3bt5xjGmeSlp769ZtNoCn\ntrygP9ZDlO/lofZT0dmGqKWe2iUzyrKRR1eo0jlPvgcbLQxJGPZaP6+6FBanF46W\nE5bdOUvrFVxlhHQJgTRgA65r1yoQZBt2ny0J8vRROJ0M9cDq/Cob0ymPAVmzelcq\nKIppqrERoIBAhRVrLMq17KKbGdnzjSLmBzs4mJoL6ARHQ54ixMOxiXMCkEY8fpzv\nFygBBnfZAgMBAAECggEAAphLRqGCaOtRRhEsL0/iBXbEd8xBAiDmzLfrsK9p9lfM\nkcLJ+kUazScAQCt+hIfIUn2SbQeGSjysSiDeAJ09sA6mqfsX6uTdU5mjuBqGG5zB\nA7eITJ9374ks/zSwGwZmoH08EMMmhZDPSfpI9Dfzp1NhsPuZPrQ5aXn31YsWetI4\nzJjd8RAwx/0shsBnSAyY5axz5/v959vsYTcchQvhY9dSmH7nCpfOH2yLv5B4M0xs\n7ToA9Qr35QazIjPyKF8avg6to2z99vgtRCLvoAYicG5GnKcphSLbgk+j7g7ljfpX\nt62WAIpUt8MiKYzLms3Zi8e328jXE6S8SMxjO940VQKBgQDmcGpOQeVbxeVYEd+C\n+2SGtSPABU+CBj4s/5jmdgqo0VuNS1aqXr523eU2LGxFSatpGpc7cMTKHdmm8sez\nYElgY1OhWEZJdw2Baq5HrUQP0UODlJRD0Vq5q4UEVL9DUVSay+Js2JMe6Ux0/WRr\nqtWYxMqBCtc2DjsClawYIALsBQKBgQC1mJwpKzwcP6I3gaXI5YLTVOoBfkLxeUtx\niNMbRGwYPG4/U6nizuG0map5c3EMb8mO+iIo1EoMJ4JUGpWIGDgKR9o/vdaIqW0L\nJlUPfQWx4Q+0RRXC+akBefJEL3idfHDAT1tJVlKBVtMNlDxnxAPHUu+a8phuiA6Q\nysk8nTr4xQKBgAfeguLVQT3XDjPpuFZCu3YWLXhbNhHcoLbsq44DLe4B6Dx0/Cqp\nPZvVjARDlBbxoxbdv5haC35TcqFO3R71BMxz1+FEoHHVzPJEcFsmQZLAtKuDoWSH\ne6+nec1iD33/AwKeP8czxiJiGShNluZOWSj0X230rtC7v6wg7FWOkkr5AoGADP4j\nRirKvTasU45aHzqUlqw/peWzwnUsOa5RdGT72uwP80X4JLsqmPJZqSDiWMJyyGEL\nKqKtvZriD0RrqHYbJFkpu1/IxrRgkeinM1l9m9F/fyVmPjIArpNcCxbeaV4q7wd+\nf4vGkWx140XU4JO8tXkwnYR39YiUijWIGmchfgUCgYAR1eoSD8zHMl/i2tUIYKBT\nRMrTy+NDI4axs4TUvlxauF6qwTcL8+hvR/FfMf7nEphVO3fN4ry5T+SQ6/tVhudV\nJ/8EvRdnIC+9r+Fo9NtTQ+dHvGZoi85Tk1wmlmafBMRs90poOiA8iGBObcgzobgc\nS6469mXNrLIifCqxQWE25A==\n-----END PRIVATE KEY-----\n",
  "client_email": "eoscalculator@eoscalculator.iam.gserviceaccount.com",
  "client_id": "107436068829334904476",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/eoscalculator%40eoscalculator.iam.gserviceaccount.com"

}
''';
const _spreadsheetId = '1epg5_bEXZSF0DHJTSmXES1ICm8vvPLkkUH-z1Os_a4s';
void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = await ss.worksheetByTitle('PVT');
}
