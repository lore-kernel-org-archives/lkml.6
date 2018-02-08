Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeBHJfW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:35:22 -0500
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:55837
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:35:18 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: base 2.0 implementation
Thread-Topic: [PATCH 0/4] lightnvm: base 2.0 implementation
Thread-Index: AQHTnnsIssG1fS+P0kuEi9Mecl8ir6OaQ0KA
Date: Thu, 8 Feb 2018 09:35:16 +0000
Message-ID: <DA4E2087-F1E8-4903-9B53-95CFECD6B868@cnexlabs.com>
References: <20180205121505.27563-1-mb@lightnvm.io>
In-Reply-To: <20180205121505.27563-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2562;7:C4epg4ZencmBVWfMFpsy6fn9iCoNeC8I+HbBMF7I1p5Diq8ttYikshNDLNgQCZFNvB13LIsHGMdfn2jxSy/eQlEKlBqobznO8FB3sySmtN/dXJ9o4x+4nVbyYaFaYT50mdoi/TgzR26KXwnTlUKzB9wpXdwbmFVH2okKVzKGvwaOJNJtSOSkLb1LJsP92bzUxtZdN4fQh4BMFV2PslQxhHcLP8NN7JYU6fHob+KN8IC2iVohYdc0tPxoAdENKsyL
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: c6cf5985-5ac5-47cb-917b-08d56ed7431d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB2562;
x-ms-traffictypediagnostic: BN6PR06MB2562:
x-microsoft-antispam-prvs: <BN6PR06MB25621983A551D3F1FD88DB24BAF30@BN6PR06MB2562.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(93006095)(93001095)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB2562;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2562;
x-forefront-prvs: 0577AD41D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(396003)(39380400002)(376002)(366004)(43544003)(189003)(199004)(3846002)(83716003)(76176011)(186003)(26005)(106356001)(25786009)(102836004)(77096007)(66066001)(6506007)(478600001)(2950100002)(4326008)(68736007)(14454004)(8936002)(6246003)(5660300001)(6512007)(2900100001)(36756003)(6916009)(6486002)(8676002)(53936002)(86362001)(6436002)(99286004)(7736002)(81156014)(81166006)(33656002)(2906002)(305945005)(229853002)(97736004)(54906003)(82746002)(3280700002)(105586002)(6116002)(99936001)(316002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2562;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0DKHF7qJkXdHrRHOMzwjZHTrpA0KikJsUaSavKMPSTg34rmtkW6D9b048bHt1tzzC7VZ8nWfRcCkE7Z/aJmZUQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cf5985-5ac5-47cb-917b-08d56ed7431d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2018 09:35:16.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2562
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Feb 2018, at 13.15, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Hi,
>=20
> A couple of patches for 2.0 support for the lightnvm subsystem. They
> form the basis for integrating 2.0 support.
>=20
> For the rest of the support, Javier has code that implements report
> chunk and sets up the LBA format data structure. He also has a bunch
> of patches that brings pblk up to speed.
>=20
> The first two patches is preparation for the 2.0 work. The third patch
> implements the 2.0 data structures, the geometry command, and exposes
> the sysfs attributes that comes with the 2.0 specification. Note that
> the attributes between 1.2 and 2.0 are different, and it is expected
> that user-space shall use the version sysfs attribute to know which
> attributes will be available.
>=20
> The last patch implements support for using the nvme namespace logical
> block and metadata fields and sync it with the internal lightnvm
> identify structures.
>=20
> -Matias
>=20
> Matias Bj=C3=B8rling (4):
>  lightnvm: make 1.2 data structures explicit
>  lightnvm: flatten nvm_id_group into nvm_id
>  lightnvm: add 2.0 geometry identification
>  nvme: lightnvm: add late setup of block size and metadata
>=20
> drivers/lightnvm/core.c      |  27 ++-
> drivers/nvme/host/core.c     |   2 +
> drivers/nvme/host/lightnvm.c | 508 =
++++++++++++++++++++++++++++++++-----------
> drivers/nvme/host/nvme.h     |   2 +
> include/linux/lightnvm.h     |  64 +++---
> 5 files changed, 426 insertions(+), 177 deletions(-)
>=20
> --
> 2.11.0

Thanks for posting these. I have started rebasing my patches on top of
the new geometry - it is a bit different of how I implemented it, but
I'll take care of it.

I'll review as I go - some of the changes I have might make sense to
squash in your patches to keep a clean history...

I'll add a couple of patches abstracting the geometry so that at core.c
level we only work with a single geometry structure. This is they way it
is done in the early patches I pointe you to before. Then it is patches
building bottom-up support for the new features in 2.0.

Javier

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp8Gc0ACgkQIX4xUKFR
nnThRhAA2WJXLv0cMnWZjfxH5QYLcCzApf2A6vsQszHvLQphjYkHOt72IzCUV+Do
SaHWTX1n/vfQbvt8GnH54kDd6eqmi8Q1eleDRDx+kLlpeZym/lmRJ31WdGP3rlCQ
deK0PwnEBL5pejocoE02gAIL4e/+mJZGj855MaYrgohFmZWODeJBk83XafQkp4Qo
XE+wjEBFH33KZ7ycbk9jdWpmUci5PIM87pToKZL4bDoM19sb27PiqqkEN1b/dQsc
zO4BWI7wZvcfZWLqPYfwVAog4vheb0DVvud3r2yyPRqHRL3x7jON8yJn3wOqkzTJ
F9htEGRfvn+RgAdlhlyIgf6uzkOKadreIT7lYkiu3mvh0rlnlsOHcWxZJPLhK3/W
07piOdkup8wdZef8RSsymQzxWLqdnnmq3QMuRtNBV6fftkLy5lipDIq/06M4egge
MmU/n8uLmJkheMcQMSK0BimnNck619+U53AJ+LdVTupoi23Q1cBVS+86G5qFywFv
g6DuilBXrnMcyBvTj3DN0CpN4qXQabQ7qZCfRfASHIlm/niWSmwm66rDlJ4oxpGN
jiYzu46MEnhqi2jVEwiorIhaNkDc6UpT7zJXfufUz5jPb+rzVmRLSoTDheF6MlX8
gPXXDEujVTFvx983T9+ngccVLJH6lYYEp6orQAgVtyT+lEp0QY4=
=93iq
-----END PGP SIGNATURE-----

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41--
