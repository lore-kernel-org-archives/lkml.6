Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeBPGs2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 01:48:28 -0500
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:34371
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753313AbeBPGs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 01:48:26 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Thread-Topic: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Thread-Index: AQHTpl6hYkpXdBKtg0aoHleBBn4AMaOml4eA
Date: Fri, 16 Feb 2018 06:48:23 +0000
Message-ID: <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
In-Reply-To: <20180215131200.3354-6-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [24.5.37.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2801;6:TMTAPXelllYNjYXCgf6Uoey7lJtzb/uZwrlm34beKtt1Gktl9d0WkrrPf1SeFAMSL0nVLMp6r77pNAFCrYtNMkD+MdRNYJwy2atpfDNhvMd3HpAdQhFVaPrn0e1YJeELWZkQfgJ39bUGsk5ZIdVe3S9NEVg11q1rGRyHqK7Eh5k+Uet3qYpMHAiasqG0RXiCxjRBzWNPM+cdlrd8vEVx4V7O9PB2lnHTlMvl93h+pviGu2a+oDi0BPGds6lpsP+qYrlkyqwn1OgpwP3TOdtDsyZOF1b6679sQj//fP/7Ogl0RoBXxfOAc48SxLncq8TWcXSDpYfdwNFDDNlLq50Wfb8l9V86UBwMJpF0ZW3ujhCApuH7bYbxExLX35OwMntg;5:seQJZOGsAN/aS/u3QqAfwNdjRmG95FyN5QyUIaeQFnN0Ov6PI9UUeth06dwg702tZ0vc82vVk3zm/q2NBwGwZzFGpeTx/ugaOaYBVTNwZvN/PTL4/+4SiZv5Iym1MtUhu3RgfK0W9qLZSdy899pdEQC5ouihacTyprZp/QU4sd4=;24:NvcnSlMBxWVxug+zcFEV2wny2YerRo5V05Xhi8mxVX8xqdiiXI3RWlS8tqxMv1Wq5/ZtZ6dv3WHtE0JWML7Y64WWs+KTqFAiEg/CtfEtaZk=;7:CIku4YnhOXp3srWzp9B3qnTWvtyHSKjepQBCrYm8ItyM/u0K869g2cYhMaHhYXKhRt7L5nADtIbZ3Y36d4fLyZn1yWuBUZ7sXMxm86rTf1fzSEL0+cotsPePxqYuxw9hu3vxmUElGcKJTgatnEyYptmdLUe1IPrKDTHKz8Ctar+WZU86A4AriwJEId2RXEciBPPTYrfguIOjA8lPppreSr+0Of7FRxeO2lwmoftuo3vLl4Bae0RGFNqPolHASBez
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f53282fa-b7b7-47d4-b2b8-08d57509463d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB2801;
x-ms-traffictypediagnostic: BN6PR06MB2801:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-prvs: <BN6PR06MB2801077C3539F2D59C6741C2BACB0@BN6PR06MB2801.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001036)(102415395)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(93006095)(93001095)(3002001)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR06MB2801;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2801;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39840400004)(396003)(39380400002)(366004)(189003)(199004)(66066001)(316002)(6506007)(8936002)(54906003)(6486002)(6116002)(81166006)(81156014)(82746002)(8676002)(3846002)(3280700002)(77096007)(6436002)(68736007)(26005)(14454004)(229853002)(186003)(99936001)(33656002)(478600001)(106356001)(102836004)(97736004)(4326008)(86362001)(105586002)(5660300001)(2950100002)(6916009)(83716003)(76176011)(2900100001)(25786009)(36756003)(7736002)(2906002)(6246003)(99286004)(3660700001)(53936002)(305945005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2801;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MEa1tkbG3u+982M4rxJMHaHrvzf8FEb78y+CE8jczQ2xodD0D6nSV1yAmSNRanxfhkGC4e/sUlpvBhl81myISA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53282fa-b7b7-47d4-b2b8-08d57509463d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 06:48:23.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2801
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 15 Feb 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The value of max_phys_sect is always static. Instead of
> defining it in the nvm_dev_ops structure, declare it as a global
> value.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c          | 28 +++++++---------------------
> drivers/lightnvm/pblk-init.c     |  9 ++++-----
> drivers/lightnvm/pblk-recovery.c |  8 ++------
> drivers/nvme/host/lightnvm.c     |  5 +----
> include/linux/lightnvm.h         |  5 ++---
> 5 files changed, 16 insertions(+), 39 deletions(-)
>=20

The patch looks good, but I have a question. If a target implements the
scalar interface, then it will not be limited to 64 lbas/ppas and it
will not make sense to split the bio base don this value. In fact, it
looks like in time, we will move to a scalar interface in the 2.0 path
to align with the zoned interface, so this value will be dependent on
whether the target is using the scalar or vector interface.

Javier

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqGfrUACgkQIX4xUKFR
nnR4qhAApHPsuY+VDzpeKEgVr40k1slDSVta6dG4h3ZuEiYKf5Sf+IQdi2EGg970
R8g9HvBNucDHETNxTksojcOmJM9SDRLMnMFxwOS1BI39YWYHu3ira3qjJEZea7CZ
5ZKGY/qERt/wxyLPEIbZ7CbF6GVICfgMfOvL4xMQLJQc+F2V/INZkmek0NO9Sjvu
vi3qDHTlJhQRpUdHmOSDaPrQ+fvohNYb3o5JHS/NvMX6Mm/qLOskbY3658Zp0tHH
oqs26nWRgz878ns6zCdfFCgUrCofQkZiTD6UMkY3hVpuspZU/MIslsjhj04hpNS1
MSjOV0Djp0XaSXlWZN5AggpOXymnh/NxmojgP2eEBS7bn/R9CuN2+OKmtx5OEvO9
o0Lhq+INzDD8p3E1MnyCssf9IezdcG+6C6Ap1EOQIkky0t1jiYEQd3uArMJTiRFN
NP4M2DAw/jCFtWNdLumapSbWdqEfEkldAlrzkjfYG4Ccp4LH8VYBA4f4I9S+9pOu
qr/F1U+5b/i4jwDEBSPPMdgHHgPXbAZYwWqfKV62IftVnSBi9Wz1gzi+SlQ1fLaN
aSmIotRtmo0gsdczKYy1TzFmuf4bLNltdO+eD1Bqlc1j41cDmGBawy7NwL3LPhh9
O+vI8iu/D7Lcmgj8TO2HV20WKDy+o4l+MkubzLaaGBAGO5AdYhY=
=qVlh
-----END PGP SIGNATURE-----

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5--
