Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeBDSZc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 13:25:32 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37910 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeBDSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 13:25:27 -0500
X-Google-Smtp-Source: AH8x224TVAreldvRLTa3bcEOBMPYPrQXDDmcfOtsgR3+CVQp86T+nu8PWw97/GkXu4bnIiFrrVdH3w==
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com>
 <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
 <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
 <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
 <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
From: Steven Presser <steve@pressers.name>
Message-ID: <eed11463-a2f6-0b4d-6138-f5082f97dd5e@pressers.name>
Date: Sun, 4 Feb 2018 13:25:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms030500040201030201090403"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030500040201030201090403
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Andy,


The information is in kernel bug 198671.


Steve


On 01/30/2018 04:20 PM, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 10:12 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jan 30, 2018 at 9:27 PM, Steven Presser <steve@pressers.name> =
wrote:
>>> On 01/30/2018 02:05 PM, Andy Shevchenko wrote:
>>>> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name=
>
>>>> wrote:
>> Let's do this way. Create a bug on kernel bugzilla, attach output of
>>
>> % acpidump -o tables.dat # tables.dat file
>> % grep -H 15 /sys/bus/acpi/devices/*/status
>> % dmidecode
>>
>> and share the number here. I will take it.
> Here [1] is the branch with another approach. Can you test it and tell
> if it fixes the issue?
>
> [1]: https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi
> It's based on linux-next + compiletest branch of IIO subsystem.
>



--------------ms030500040201030201090403
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
C+QwggXiMIIDyqADAgECAhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNV
BAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1
wLUZr5gkrLtXedg17AkefMyUGwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV
/8Sp5lZEuiMnvMFG2MzLA84J6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyy
QzxvuA/GZwKg7VQfDCmCS+kICslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7
m1uTyHaKZspMLyIyz6mySu8j8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+Lat
oWELrjdI4a8StZY8+dIR9t4APXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0f
BCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUF
BwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUF
BzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSB
bDlhvkkPj7cbRivJKLUnSG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8G
A1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5S
H9uh2NCXTq7im61g7F1LIiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXB
sxsaRTYw5kG3DN8pd1hSEUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyet
OrRHPbkW4Y07v29MdhaPv3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl
149tKeqvwlvrla2Yklue/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF8
1snTr2d1A7Ew02oF6UQyCkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4
cJ2jrpmYSz/kliUJ46S6UpVDo/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6uf
QbwyO0V+oFa9H0KAsjHMzcwk3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+Jq
vTCIzv2bJJkmPMLQJNuKKwHNL8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPV
OMxLDSUCXsDO0uCWpaNQ8j6y6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOj
MIIF+jCCBOKgAwIBAgIQblaS/9kadBN5WggiIMdzXzANBgkqhkiG9w0BAQsFADB1MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50
IENBMB4XDTE2MDgxMDIyNDkxN1oXDTE5MTExMDIyNDkxN1owQjEcMBoGA1UEAwwTc3RldmVA
cHJlc3NlcnMubmFtZTEiMCAGCSqGSIb3DQEJARYTc3RldmVAcHJlc3NlcnMubmFtZTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANawlmrhSo5cCRT6pKi1VGoktCtiFh3vwsY3
D+KnXNxrTaVWcrqvEnWrcx6CYctQbvUWnxPt1Yrgnsev4TSNqPqIv+oqkwiho3UOM9AutTLa
U8RsNkoercgA7klslpjC3ItaWazN5BlRaZ8QWwpg6TjRATEG5RvNMbi31DHNM/1yinv7U495
SOSue5jvKvW639GlwxTUfWrUmtmtKJZSMpAYKwnhSehxyN8E3vzd82j4MvlrFSvPEdfIVPkt
o3K0BNAwYd2eHPVlHlWEBekNAzCQqY2vxPTjzlsusYV9lKzCPQ439D4XEWRvEDVS+wCcWepv
dgXqz38rzm4BO3T7udBDBvy2KaImZpPm1y/VHQ8ZFuRHJsdkq+E63wZuTuYFY1RJGm68vaV/
gxFSDZc4adZ/HG0+2/kPc/NuZa66yP4n58irIZXWBe6b6PvET3SUEA7HmsU1arLXVwE/TkPS
/QmGKZLCRrzpgeAP2bwuZMr+dXoNeGlGaf9TBhMXRqrRM+rvWrTst/745uqV5pUTQSJE8xha
SXUanZWZ3COcHiepdq7Lr09XAXU4QU29SgOi7cpxdZAUe0apsTMMWhJYBvISQVBvYZqPPj1X
WuCR4mAUouL8zFvt108F8iTh3VU1lCAI3ulrGqPPlJF7AXEtUGggkxwxnQR7p1Kk/BYeJn4T
AgMBAAGjggG3MIIBszAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFHEeAfB8TH+O1yTnfhhCM4F+NomZMB8GA1Ud
IwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0
YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0
cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3JsMB4GA1UdEQQXMBWBE3N0ZXZl
QHByZXNzZXJzLm5hbWUwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMEcG
A1UdIARAMD4wPAYLKwYBBAGBtTcBAgUwLTArBggrBgEFBQcCARYfaHR0cHM6Ly93d3cuc3Rh
cnRzc2wuY29tL3BvbGljeTANBgkqhkiG9w0BAQsFAAOCAQEAOBc5QbBzQ4Ghvh1xoHKcCsMj
xm38z1Z3bPWYmEWs0mQVjfT6otJ5dAhmJW8MS2I3MTIg/s8w8b9nSzah84JZT4/pqN0BLvfW
paEn3R3k2OtMnqYNglNEd45PwZO17wD1vqBSoArRXsgGn3X/jTbM+bC7E1c1AnqTePhNdd+d
nGvzFA52eL1HeyecgofMANKiFGViUBFVBW5No1rtw0cF9FVrNMubsLE5J/e/j8OOPYO/pMfr
ruOcbAPTHTEmDJJhYQ/9GQoTBOAR2J2BzbLmjNIjwnxCKggIP5QR59JBQ11JPn9MoX82GRGB
wVGNBj2Rifdg20JXDLuhQUdNVZIIhDGCBOwwggToAgEBMIGJMHUxCzAJBgNVBAYTAklMMRYw
FAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/Z
GnQTeVoIIiDHc18wDQYJYIZIAWUDBAIDBQCgggIzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIwNDE4MjUyM1owTwYJKoZIhvcNAQkEMUIEQBgPI3uL
V2po1KtXmEjMVIALg2RM2ykZySUayggzmPvjAkYZFnH/Y7upYiAkaMT+EvZn+xLkYHwWKX+d
qrRfTYcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDH
c18wgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEj
MCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDHc18w
DQYJKoZIhvcNAQEBBQAEggIArIhnYq6+LdCUgMChZGN9bpWbvE8bpXRkr6++qTYHIm29SZhe
DDkE0wG9wYwQLCeioraMA9jV4A3z15Ui3O4z4a9BUXTHL3sw7KiZeJKElDHV1Q/ZDxQzz7K0
i1K4941lCHEkNXuwuJHLqSIlwknw7qcfFpnL2M8Grr0Jhh47yNToy+GKZsovmpMXcMCnFOO3
YwV/Gsqjbzj9muAIxlabPfQWOyKB1X6Pn4Cq7o85inZoGMV8mLgSg748qKT2uC8e83GsDY2R
z1+onwp2GxmEaq5Pltv2sx6kLPE90L18sguLm9SZx/XfEPgzTl3a92xXLWyVgeSFbiqc5zpp
GOlRZRfIsKmFOTsaxY5ewY5y+fAVSNJVsZlZV0f5JS6TowSItcYHMaSdQ97RbvsNOgTJ9XVF
dvDsKkaQOYDnjAkJmLVOinibOAFgDRsGVUiWNXW2IiGMC8vx9643AwbgDVM0S65HBwcirswn
IRlprSqvd+FI4uBUkkvGGYmadFfzP/pgMaEUdaY/0VfHbqtz8JXRGdrlgIvGCIzDHsKivj3E
7g/hYBuqwm+i634OfyVy3VtSZeNNDujeZ4Yafv7C09AguxqhAQEuxo7ZVMPQX1XVVLVkyLK8
kJu78cjWUiyalRhrAfpmxL64RFpecvWNjDJ3u1sDa7JHNFcAiskImVBeLJAAAAAAAAA=
--------------ms030500040201030201090403--
