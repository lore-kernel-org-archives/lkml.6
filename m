Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbeCEXvx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:51:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:57178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932084AbeCEXvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:51:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,429,1515484800";
   d="p7s'?scan'208";a="31610049"
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] x86/microcode: Improve late loading
Thread-Topic: [PATCH 0/7] x86/microcode: Improve late loading
Thread-Index: AQHTsH8CjrVzZRvF6UmAeLXcma7uuqPCw0OAgAAbrwA=
Date: Mon, 5 Mar 2018 23:51:50 +0000
Message-ID: <1520293904.14856.51.camel@intel.com>
References: <20180228102846.13447-1-bp@alien8.de>
         <a9162ec0-0440-3369-5c07-c6d58fdb7154@amd.com>
In-Reply-To: <a9162ec0-0440-3369-5c07-c6d58fdb7154@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.102.30]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-oQu3G8vXxL6CfZP9EESF"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-oQu3G8vXxL6CfZP9EESF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Tom

On Mon, 2018-03-05 at 16:12 -0600, Tom Lendacky wrote:
> Borislav Petkov (3):
> >   x86/microcode: Get rid of struct apply_microcode_ctx
> >   x86/microcode/intel: Look into the patch cache first
> >   x86/microcode: Request microcode on the BSP
> >=20
> >  arch/x86/kernel/cpu/microcode/core.c  | 158
> > +++++++++++++++++++++++++---------
> >  arch/x86/kernel/cpu/microcode/intel.c |  48 +++++++++--
> >  2 files changed, 159 insertions(+), 47 deletions(-)
> >=20
>=20
> Tested on my Family 17h (EPYC) system (including taking CPUs offline
> and
> back on before and after reloads).  I'll try and find some additional
> systems to test on, but for now:
>=20
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

Tested on variety of Intel systems.

Tested-by: Ashok Raj <ashok.raj@intel.com>
--=-oQu3G8vXxL6CfZP9EESF
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
38Krxw7lftyvG8wXGXFOOMwPVIukmm4xO1mFFkX5zuExsBjHmB2z7gmpaQIDAQABo4ICKTCCAiUw
HQYDVR0OBBYEFNVGfbfOhQY8TjfuBceOwFEb4HuzMB8GA1UdIwQYMBaAFNpBI5xaj3GvV4M+INPj
ZdsMywvbMGUGA1UdHwReMFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkv
Q1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNybDCBnwYI
KwYBBQUHAQEEgZIwgY8wIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmludGVsLmNvbS8waQYIKwYB
BQUHMAKGXWh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVs
JTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNydDALBgNVHQ8EBAMCB4Aw
PAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhsOMdYSZ5VGD/YEohY6fU4KRwAlngd69OZXwQwIB
ZAIBCTAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDDDApBgkrBgEEAYI3FQoEHDAaMAoG
CCsGAQUFBwMEMAwGCisGAQQBgjcKAwwwQwYDVR0RBDwwOqAjBgorBgEEAYI3FAIDoBUME2FzaG9r
LnJhakBpbnRlbC5jb22BE2FzaG9rLnJhakBpbnRlbC5jb20wDQYJKoZIhvcNAQEFBQADggEBAKo4
RQHaM5pj+oplfIEYLYtMUiSlDNlI/BzqDs3lXD/DOn6WOKe95xK931fB6Q/MNN1/o+Y9mi54Pwuy
DCuAf4plGh+HieKStTDyiq3gqGjpzFgIQb8K7Y8mjl3ovfQp9actlMLt/g3aAVN2mWimTZjxbfR4
L7kBcHDmeFuR8SpdVXuFCp09OGgttjGTAh93sEGdRKVWwx2QNZn6r7XeAsZ5lv/JxnQuj9JxdA/L
jPx0etEM2/8iFcKt8LGX+C3N50wI73WNWLVzmKu+0p5Hu0QV0QWObKp6aUdzVYbvAhNOcUabPN+a
xtX9fazV0dsXcIdAnRV6apLXfFwPlnNZGVcxggIXMIICEwIBATCBkDB5MQswCQYDVQQGEwJVUzEL
MAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRlbCBDb3Jwb3Jh
dGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0QgITMwAAPuvp
6Gvbu6B/1gAAAAA+6zAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTgwMzA1MjM1MTQ0WjAjBgkqhkiG9w0BCQQxFgQUj/2cOrDln38Rj1ACgQaX
n7rhzCowDQYJKoZIhvcNAQEBBQAEggEAhL9sJ9+oc/RiVTl7zqc0kXI0RLewKmXZOWjfnuOihPhi
+6faCYqiHgx5yixUyZmMIFWSbg5GfxC/eUaS2xmQRaL6uHoHMRwjcWIciVIuaXaHQufKiytoSs1b
wSV13gJljFtYj8YqJ4Y1Q3Jz2wh9ip3kThvGa/fgdtnZ0qnkqWaH9xX5aK265UyO4mbKuRuUjGXy
bgRqzQkDD9s0iQ4FZV3X1oCRXOZ46UUcoQ1gZaE884VRLOCaZA/hA6Kp7MOv906psnbQs8RYjPII
alBQq5QHR0Obs5Z4hg34APIuAXbwX/9mBMaEfA/isjSnCE9/xrJiCAhqGGKPPcKfksrDZwAAAAAA
AA==


--=-oQu3G8vXxL6CfZP9EESF--
