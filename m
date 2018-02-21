Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeBUJfK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:35:10 -0500
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:16928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753200AbeBUJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:35:07 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 0/6] lightnvm: base 2.0 implementation
Thread-Topic: [PATCH v2 0/6] lightnvm: base 2.0 implementation
Thread-Index: AQHTpl6dkzWJx0Rjak2rNFwLVm06W6OuobUA
Date: Wed, 21 Feb 2018 09:35:04 +0000
Message-ID: <A2E4F5B5-2545-48CC-9514-A5BCDF9A9D02@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
In-Reply-To: <20180215131200.3354-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2787;7:KoYmViuTn78Q5fh1kzP/CSa7kpdHc9jGdME1tHxCYJL0iQoDOj//pIHypl9pQMv5sMzKMg616X34zegjnID0a+76TvhoUufO/+lxJ1QvrA/g7lHBhv0RFDCUzr/+wEPHQqbrbSYeF87KH3hKP1pJmlTB4h4PqrMfg9vfTSxBKZYsJemWSXtZxkI0rS7xOEpVZQ9p70JIG3jXmLKBXC2dRPNp0uU5qk8SX3l+MbEZiwXtIFYnl85VYolHQw2zsYXp
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 915cc360-b3d3-4e0b-2c68-08d5790e6390
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB2787;
x-ms-traffictypediagnostic: BN6PR06MB2787:
x-microsoft-antispam-prvs: <BN6PR06MB27874ADD6B207E6E6C5DBDB8BACE0@BN6PR06MB2787.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001065)(102415395)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(944501161)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB2787;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2787;
x-forefront-prvs: 0590BBCCBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39840400004)(39380400002)(376002)(346002)(189003)(199004)(82746002)(6486002)(6512007)(53936002)(6436002)(8936002)(76176011)(97736004)(54906003)(99936001)(316002)(81166006)(81156014)(106356001)(8676002)(68736007)(36756003)(6246003)(3660700001)(99286004)(3280700002)(33656002)(66066001)(4326008)(478600001)(26005)(105586002)(305945005)(229853002)(77096007)(7736002)(86362001)(6506007)(6116002)(102836004)(5660300001)(2900100001)(83716003)(14454004)(25786009)(6916009)(59450400001)(186003)(2950100002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2787;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: IsB/xcng8KnMEbFAeXEX3LmnGkN6jzOWj84n+VRiV746QDavgKC4ZokC+oF+jNBFgGOql1pMhb1I0wDDASCWyQloY7fIB4F6gLd0OKWZpDvHu4H3OWrqCPvAf1tQjOkfX+WgGkbfbhHKPIp8ttmLmPeqKRiLiLlJ7z57DMxCkQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915cc360-b3d3-4e0b-2c68-08d5790e6390
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2018 09:35:04.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2787
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 15 Feb 2018, at 14.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A couple of patches for 2.0 support for the lightnvm subsystem. They
> form the foundation for the integration.
>=20
> The first two patches is preparation for the 2.0 work. The third patch
> implements the 2.0 data structures, the geometry command, and exposes
> the sysfs attributes that comes with the 2.0 specification. Note that
> the attributes between 1.2 and 2.0 are different, and it is expected
> that user-space shall use the version sysfs attribute to know which
> attributes will be available.
>=20
> The next two patches removes max_phys_sect and max_rq_size, as they
> not used.
>=20
> The last patch implements support for using the nvme namespace logical
> block and metadata fields and sync it with the internal lightnvm
> identify structures.
>=20
> Changes since v2:
>=20
> - Removed blk_queue_block_size() setup in nvm_init and made sure
>   to only update csecs and sos in on the late setup path. No reason
>   to set it twice. =46rom discussion with Javier.
> - Added two extra patches, that removes max_phys_sect and
>   max_rq_size.
>=20
> Changes since v1:
>=20
> - pr_err fix from Randy.
> - Address type fix from Javier.
> - Also CC the nvme mailing list.
>=20
> Matias Bj=C3=B8rling (6):
>  lightnvm: make 1.2 data structures explicit
>  lightnvm: flatten nvm_id_group into nvm_id
>  lightnvm: add 2.0 geometry identification
>  lightnvm: remove max_rq_size
>  lightnvm: remove nvm_dev_ops->max_phys_sect
>  nvme: lightnvm: add late setup of block size and metadata
>=20
> drivers/lightnvm/core.c          |  61 ++---
> drivers/lightnvm/pblk-init.c     |   9 +-
> drivers/lightnvm/pblk-recovery.c |   8 +-
> drivers/nvme/host/core.c         |   2 +
> drivers/nvme/host/lightnvm.c     | 513 =
++++++++++++++++++++++++++++-----------
> drivers/nvme/host/nvme.h         |   2 +
> include/linux/lightnvm.h         |  71 +++---
> 7 files changed, 442 insertions(+), 224 deletions(-)
>=20
> --
> 2.11.0
>=20

The patches look good. I tested them together with pblk's 2.0 support
and all works as it should.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqNPTwACgkQIX4xUKFR
nnSkDRAA2d4ihIDk58XZPqRuHmLdR3nREk5KpKvCXqZklv29NNjh0n2/JP38ZnJt
L4aJLkZSdU+ZMHzfdRp0Sbl9TTpPBQSHxJM332vzDy3GqHsV6G4YNgv2mYPlO9z5
x9bxO7JyWgLf9a5grjK737iHj7GsPCWYIIOOcec8d47LqDHofjrjSgb9uS07RYnR
9tWcjhl7JyOZBqW82So7uGaKYg9Rcv//4Af3nXoxebAqzOiVEoDncN2gbTsMEASi
p28brYAKQFn4LAuYiQ5XAsrjbkJwbRDdLuteacNEbnp4KbWAgIRAjc3zw+cojLTe
gFwXMKKWAX9jGvYf/JFXBfpbPR9QXTosukfc4vCa4sELe5nq9YDeQRkc9VPpotW7
HU8tbEUOQXRGCL+5rAwbl9Z5egAlVFUzMIaMfuS+sBxaPLp/MAPl+SoYVqXcSY4x
M0OROy+CxjLEDEBY+tVZggSIPU8p9452GN4RiwiDpLgYJV69+IWdsSUY0qTE1zBC
WROY32QdojX5MH09LcOZKQUGI0ommUp9oMCRcp5B+uVocVOETEIGsy7rMuOq7qNL
hm+7h6JdBgN9itBzfLwJCLZrPcSzS45Y0yc5udK/eEUpMHWkgzjKtXxdncgvHZu3
THsxOsfYppughEXr4z7l+DGjz6n19d+P0tTo9KkwEcQ+oACZThU=
=9oMq
-----END PGP SIGNATURE-----

--Apple-Mail=_5735A141-5487-45A1-A32B-C49B7E1FCB0F--
