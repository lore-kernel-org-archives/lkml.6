Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3802145D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3802145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGQKhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:37:48 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39325 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729661AbeGQKhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:37:47 -0400
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F12CD2012BA077;
        Tue, 17 Jul 2018 12:05:54 +0200 (CEST)
Subject: Re: KMS does not work on MSI B350M MORTAR with AMD Ryzen 3 2200g
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <ba7e0ef4-5b5c-76d7-304d-6bdd2ad55b80@molgen.mpg.de>
 <CADnq5_M6JRbBabcJWdft7QPOaZcww+g+4E4Ssn32cPwTN6ob3Q@mail.gmail.com>
 <758d29fc-588f-fd7d-cfa3-68c278f24562@molgen.mpg.de>
From:   Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <8d20128b-c817-1467-e214-6b9065bc4f8b@molgen.mpg.de>
Date:   Tue, 17 Jul 2018 12:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <758d29fc-588f-fd7d-cfa3-68c278f24562@molgen.mpg.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060900060203030500050400"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060900060203030500050400
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Alex,


On 07/17/18 00:00, Paul Menzel wrote:

> Am 16.07.2018 um 18:30 schrieb Alex Deucher:
>> On Mon, Jul 16, 2018 at 12:14 PM, Paul Menzel
>> <pmenzel+amd-gfx@molgen.mpg.de> wrote:
>>> Dear Linux folks,
>>>
>>>
>>> Trying to boot Debian Buster/testing with Linux 4.16.16 on a MSI B350=
M MORTAR [1]
>>> with a Ryzen 3 2200g and a monitor connected over HDMI, when kernel m=
ode setting
>>> (KMS) is enabled the monitor does not receive any updates, that means=
 I do not
>>> see the login prompt and only the Linux and systemd service messages =
from before.
>>> The system seems to running though.
>>>
>>> Debian=E2=80=99s package *firmware-amd-graphics* [2] is from August 2=
017 and therefore
>>> outdated. I manually installed the firmware files from the Linux firm=
ware
>>> repository [3].
>>>
>>> Here is the log.
>>>
>>> ```
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652026] [drm] BIOS=
 signature incorrect 0 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652058] ATOM BIOS:=
 113-RAVEN-106
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652096] [drm] vm s=
ize is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652107] amdgpu 000=
0:38:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M use=
d)
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652109] amdgpu 000=
0:38:00.0: GTT: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652113] [drm] Dete=
cted VRAM RAM=3D1024M, BAR=3D256M
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652114] [drm] RAM =
width 128bits UNKNOWN
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652170] [TTM] Zone=
=C2=A0 kernel: Available graphics memory: 7703370 kiB
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652171] [TTM] Zone=
=C2=A0=C2=A0 dma32: Available graphics memory: 2097152 kiB
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652171] [TTM] Init=
ializing pool allocator
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652174] [TTM] Init=
ializing DMA pool allocator
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652202] [drm] amdg=
pu: 1024M of VRAM memory ready
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652203] [drm] amdg=
pu: 3072M of GTT memory ready.
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652220] [drm] GART=
: num cpu pages 262144, num gpu pages 262144
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652433] [drm] PCIE=
 GART of 1024M enabled (table at 0x000000F400800000).
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652541] [drm] Supp=
orts vblank timestamp caching Rev 2 (21.10.2013).
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652541] [drm] Driv=
er supports precise vblank timestamp query.
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.652983] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_asd.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.653276] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_pfp.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.653498] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_me.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.653668] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_ce.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.653960] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_rlc.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.654817] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_mec.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.656137] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_mec2.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.658217] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_sdma.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.658220] [drm] use_=
doorbell being set to: [true]
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.659663] amdgpu 000=
0:38:00.0: firmware: direct-loading firmware amdgpu/raven_vcn.bin
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.659667] [drm] Foun=
d VCN firmware Version: 1.73 Family ID: 18
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.847424] [drm] VCN =
decode and encode initialized successfully.
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852189] amdgpu 000=
0:38:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852191] amdgpu 000=
0:38:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852193] amdgpu 000=
0:38:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852194] amdgpu 000=
0:38:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852195] amdgpu 000=
0:38:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852197] amdgpu 000=
0:38:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852198] amdgpu 000=
0:38:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852200] amdgpu 000=
0:38:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852201] amdgpu 000=
0:38:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852202] amdgpu 000=
0:38:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852204] amdgpu 000=
0:38:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852205] amdgpu 000=
0:38:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852207] amdgpu 000=
0:38:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.852208] amdgpu 000=
0:38:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
>>> Jul 16 17:54:39 tokeiihto kernel: [=C2=A0=C2=A0 25.856580] [drm] Init=
ialized amdgpu 3.23.0 20150101 for 0000:38:00.0 on minor 0
>>> ```
>>>
>>> The messages `[drm] BIOS signature incorrect 0 0` stands out. The lat=
est
>>> mainboard firmware version 7A37v1F from May 2018 is installed [4].
>>>
>>> Booting with `nomodeset` works.
>>>
>>> Please find attached the full log with the KMS boot messages in the
>>> beginning, and the nomodeset messages in the second part.
>>>
>>> Do you have any hints how to get modesetting to work?
>>
>> Are
>> CONFIG_DRM_AMD_DC and CONFIG_DRM_AMD_DC_DCN1_0 set in your kernel conf=
ig?
>> Those are required for modesetting on raven.
>=20
> No, the second option is not selected in linux-image-4.16.0-2-amd64 [5]=
=2E
>=20
> ```
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=3Dy
> # CONFIG_DRM_AMD_DC_PRE_VEGA is not set
> # CONFIG_DRM_AMD_DC_FBC is not set
> # CONFIG_DRM_AMD_DC_DCN1_0 is not set
> # CONFIG_DEBUG_KERNEL_DC is not set
> ```
>=20
> It=E2=80=99s selected in linux-image-4.17.0-1 [6]. That version is not =
yet in Debian
> Buster/testing.

I upgraded to Debian Sid/unstable, and KMS works with linux-image-4.17.0-=
1,
which has both of options selected.

> I wonder, if in the future the Linux kernel could give feedback to the =
user> if options are unselected.


Kind regards,

Paul


> [5]: https://packages.debian.org/sid/amd64/linux-image-4.16.0-2-amd64
> [6]: https://packages.debian.org/sid/amd64/linux-image-4.17.0-1-amd64


--------------ms060900060203030500050400
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA3MTcxMDA1NTRaMC8GCSqGSIb3DQEJBDEiBCBaIFqONdKe9lQ2xIXU
wlOD3h/6ozQgdyxTaiA5fX0nJDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAFoA
pWTlMYWIK6wbQ7vbK4pQ0I+ikGB8aAHHOPVr3sTnbf08nCSC8NuwQqSLyiXBjAy1kWWrYmig
3BNaWtLwIWLYQaGijrqpqN7+y7B53b8nsSPj5ZY2ZIUW6ikBJZZLZoq9Z414v95y3eLZccyn
CglpB7BQCz9K/0GwUMhEprY7+p2InMurWOal4rsN4rkjj0QQTtdxBdFVUL4JIETVM5Sx3uI7
D0zaLDPpBAbpAhTGyN974t12a3PKB836o4F1Bs2VpINFbFTvAwiwPpmPhSlhuIH4zyZm2M/F
7GwnUzuuomKkbMXESp5KvOx8oA8LzXEt1euSCntQSCZ2mZfjxsMAAAAAAAA=
--------------ms060900060203030500050400--
