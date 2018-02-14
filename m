Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161880AbeBNSZs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:25:48 -0500
Received: from mail.vandersterre-it.nl ([82.94.165.241]:36417 "EHLO
        merne.coecu.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161763AbeBNSZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:25:46 -0500
Subject: Re: Read-protected UEFI variables
To: Benjamin Drung <benjamin.drung@profitbricks.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1518612748.4749.29.camel@profitbricks.com>
 <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
 <1518614486.4749.33.camel@profitbricks.com>
From: =?UTF-8?Q?M=c3=b4she_van_der_Sterre?= <me@moshe.nl>
Message-ID: <e04b687f-30cd-c200-d08f-36b7dcc582a6@moshe.nl>
Date: Wed, 14 Feb 2018 19:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1518614486.4749.33.camel@profitbricks.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020603080208060802080503"
X-milter-spamd: ham (-1.0/5.0 ALL_TRUSTED)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020603080208060802080503
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 02/14/2018 02:21 PM, Benjamin Drung wrote:
> If the UEFI is as secure as storing an unencrypted file on a hard
> drive, I am satisfied. Or do you have a better idea where to store the
> SSH keys for a diskless system that boots via network?
I assume it would be best to use TPM for this (if your systems have TPM c=
hips), it is designed for use-cases like this. Searching for "tpm ssh key=
s" gives a decent amount of results. Mostly targeted at user keys instead=
 of server keys, so this might need some tinkering to get working.


--------------ms020603080208060802080503
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CeUwggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4
dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290
MB4XDTE0MTIyMjAwMDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAImxDdp6UxlOcFIdvFamBia3uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdh
TpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYepLkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak
+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayTQLm1CJM6nCpToxDbPSBhPFUDjtlOdiUC
ISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9UjewM2ktQ+v61qXxl3dnUYzZ7ifr
vKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3RhUL7GQD/L5OKfoiECAwEAAaOC
ARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBSSYWuC
4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4dGVybmFs
Q0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb
4yJjnFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ
26Y3NOh74AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT
9HaSyoY0B7ksyuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInl
tukWeh95FPZKEBom+nyK+5swggUuMIIEFqADAgECAhEAlrATjs9A/Az9TS8fovkULDANBgkq
hkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMB4XDTE3MDMxNDAwMDAwMFoXDTE4MDMxNDIzNTk1OVowHDEaMBgGCSqGSIb3DQEJ
ARYLbWVAbW9zaGUubmwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCkqvJ6x+YV
vlVCmt41h0ZoHPErvZAaNIvAMMsd74w1qUmiwDo8LRK0ourIZs1JksBvt6KBzvBjjbtTXt/y
097E/3+geIFJ8FkvqPOchs4fMtwlCsr2r99x5bCxKYEZvYFC2dy7jNm3wcp1qLSyJIxqZwEf
GDqqeSXjgCRNANoxMcVNpf4BgGt6Bf20oNnq8Jgue2uz4Y4gotqCSNdgtDoZN7l2+tQzn4xX
ch7ppGPmWT2LTP3Qx2zB2duqTSyf/mduc+56RDWE8zWIOS4QkbyAQt0n3zuT/UEmUhEk6Qbv
EAQdcq7FzQgtWJzv+niTu+JmiYxLbFWAHVvvCYgewJVtAgMBAAGjggHpMIIB5TAfBgNVHSME
GDAWgBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAdBgNVHQ4EFgQUxtthepY3D/53wnBlbE+xiXTC
O2kwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQG
CysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEB
AgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBdBgNV
HR8EVjBUMFKgUKBOhkxodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGll
bnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGQBggrBgEFBQcBAQSBgzCB
gDBYBggrBgEFBQcwAoZMaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2Q2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0
cDovL29jc3AuY29tb2RvY2EuY29tMBYGA1UdEQQPMA2BC21lQG1vc2hlLm5sMA0GCSqGSIb3
DQEBCwUAA4IBAQBD7vkX5hB3pbDh7qVOX3ZWaOQDQ00Qz5DdTstbyqD3bboiaGbRMYsiqq1x
ztJU9gKqOIm+h7AsoVyz+Ci158bK1v0S2BzK78EUFeCyvJXPzc7DHsXzdN8SIYyhI4RQpje8
AqzxQy2T4B5OUlsb2qlAGJq3FYhj0chW+lkv7xTLteXcHAo/GV/pgwcx36ehvWcYa/fnfFgf
63syLrW1pYYUF87dOpcy37V+c6iZFHlvi+qTCImF1drVLz3d5kjEjuSNXVk1Ug32Xmg8lqen
imiLiyn3MG1mumVgWQqTYV2b1r8el3xuhdNNwSPtWJcHGE+B0bBLEpxEv3Pjz6ETsfQWMYIE
RDCCBEACAQEwgbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAJawE47PQPwM/U0vH6L5FCwwDQYJYIZIAWUDBAIBBQCgggJjMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIxNDE4MTg1OFowLwYJKoZI
hvcNAQkEMSIEIDyR4fEKrHBC/o+MnhBb8NT1rOf/rv1kxGcxnghCpfbiMGwGCSqGSIb3DQEJ
DzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0D
AgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgcIGCSsGAQQB
gjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAlrATjs9A/Az9TS8fovkULDCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
cmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJawE47PQPwM
/U0vH6L5FCwwDQYJKoZIhvcNAQEBBQAEggEAU7E+uHm3hkbl2mehsBsI2d03E/QIlXI72lJm
R2SDmjPi9eqhnc3Ba0Kvipz5eoakxRI2ITd0iPb4/mSGZlBUDS1M7Jhli23RGo3ZW+vFrINY
3OJ+/snnmpPZbfdiPNQxdFpmu2XQD6mqnoHZqsoXJzCgRnQyiizAQU40SiYo2kvfpqYMwuL2
tnrmpPxqFvW6vH0Y9FCOyG8yqFm/kw12dDpHJPuOEHERSoB8CudW36BT2zOLFHIW4W6cP8WT
IBGBmpzeY0h45ErK6r8nAWtCl5OXWw1m7goH/i+GnBuEI+U3tYsSP93JZo7juqXpiwmUroBB
GE5EhA2Bk5MKPg20tQAAAAAAAA==
--------------ms020603080208060802080503--
