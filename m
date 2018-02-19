Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeBSLFY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:05:24 -0500
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:37232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752486AbeBSLFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:05:21 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Thread-Topic: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Thread-Index: AQHTpl6hYkpXdBKtg0aoHleBBn4AMaOml4eAgATDDoCAADu3gA==
Date: Mon, 19 Feb 2018 11:05:17 +0000
Message-ID: <CE52AA06-A417-4BD6-BCED-EB4035FC6906@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
 <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
 <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>
In-Reply-To: <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [80.163.36.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3281;7:9mgqWv8iyCF5N4SllQNvkil9hdIU4e4U0/McH9ETNRwUlH62oAO1YOjRzeCQuqffffceQGuC/dKdxC9YDU88JFwba7C4g+Zfcc92piGwoZYq3zPFHhnTmOv4nlnl3T+FxSNou1uzn7m+UmNfiWaI5LeaRwYOeTLTEGG6Gb5QJfmlGu3vGk3dh64XBS0jg9l4slewv4Rx2+Fzf9+8nyNKJUt8ubwPbqH09hyRC4Lemo0z3E7/OXisXyLPJXDVgD0y
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: c8f3d665-9ec7-40e7-2e32-08d57788a92e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3281;
x-ms-traffictypediagnostic: BN6PR06MB3281:
x-microsoft-antispam-prvs: <BN6PR06MB3281DE12B4F7F236757D6917BAC80@BN6PR06MB3281.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR06MB3281;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3281;
x-forefront-prvs: 0588B2BD96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39380400002)(39830400003)(396003)(189003)(199004)(105586002)(25786009)(3660700001)(6246003)(6486002)(53936002)(316002)(53546011)(6506007)(2950100002)(97736004)(6916009)(478600001)(7736002)(229853002)(26005)(102836004)(186003)(6512007)(6436002)(3280700002)(68736007)(36756003)(54906003)(66066001)(305945005)(83716003)(82746002)(99936001)(2906002)(93886005)(106356001)(14454004)(81166006)(8936002)(76176011)(2900100001)(77096007)(8676002)(81156014)(33656002)(86362001)(5660300001)(99286004)(6116002)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3281;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: tNG+YIrIfNLsY1vVXu+SSwbFscdOQJjFdQErnLyrY46JbFtvCQL5U7D7WOjfJxUhUty7eNkm92xFtRK/jWzw6EXToRtO/bUQeJp+aifJORFuFtB+UCRJvpvbWicDcXVxxMjWFxFpIIpoS3jhoxDs+8AhI9BpvG4lQTN13Rmsv7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f3d665-9ec7-40e7-2e32-08d57788a92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2018 11:05:17.6989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3281
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Feb 2018, at 08.31, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/16/2018 07:48 AM, Javier Gonzalez wrote:
>>> On 15 Feb 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> The value of max_phys_sect is always static. Instead of
>>> defining it in the nvm_dev_ops structure, declare it as a global
>>> value.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/core.c          | 28 +++++++---------------------
>>> drivers/lightnvm/pblk-init.c     |  9 ++++-----
>>> drivers/lightnvm/pblk-recovery.c |  8 ++------
>>> drivers/nvme/host/lightnvm.c     |  5 +----
>>> include/linux/lightnvm.h         |  5 ++---
>>> 5 files changed, 16 insertions(+), 39 deletions(-)
>> The patch looks good, but I have a question. If a target implements =
the
>> scalar interface, then it will not be limited to 64 lbas/ppas and it
>> will not make sense to split the bio base don this value. In fact, it
>> looks like in time, we will move to a scalar interface in the 2.0 =
path
>> to align with the zoned interface, so this value will be dependent on
>> whether the target is using the scalar or vector interface.
>=20
> Both read/write and vector interface will coexist. I am only removing
> what is hardwired into the specification.
>=20
> The read/write interface has always been able issue more than 64 LBAs,
> it is instead limited by what the hardware reports its max transfer
> size to be.
>=20

Exactly. I was thinking of a similar mechanism for the vector interface
to simplify integration with the scalar interface and avoid having an
if/else for what we now call max_phys_sect.

I guess we can wait and see what the code looks like when we adapt pblk.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

Javier

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqKr2sACgkQIX4xUKFR
nnQkJQ//adk6w3jU1du8PM+to5WjuCwafd+lEUhE+sFIaqhP28IwuRpAlanIt1I8
24W3T7Iy9Zw/gDx8KwXTuOV3wIbxGMRyxk/2dD00u18L8VssQkVhpooZmuSWgrbs
Otf80oIkFQeiK0YarD82IfM7Wn/fzJSLtidq9d/MZRBl7S4xswZkNyzqRJr4Snwz
vcqoMb9gKtEmcEz06peK+bwbpyGWKe4vTgdDZF2vBfyyrsEV52f66kuFTlK1uW9S
WVe4qfN1pJ9ngWSJLPtbf/UOkDtjbqH2we5Ydh+oVQLdMLP+HxkfyKaa0y1cbLs9
xAaRyVCP0HPtEKk00C4l06UYh5oq60AvhnMnG1nKTEvxEbXXEwa0OZZQuJm+4m33
LV2LUA/z+rENmC4eH5MOAiPsAy2xXlP4PIyOBxsqm2xK1IMn23hMtxtluQdSlUgj
TUxlYxjVlKIk5hOmaVMIUWNUGcc+gsVAoyEZTaiHn5sTt7gV9bRZe0T6uDUybc9J
KYpZdnjLyRUput+t91x9//7y+6cH7z8iRskSV3iU5QnGKZvwKLZBDC+mZcNEKk6f
9+lxEPgiLESa4SsjAoD0TAtaNxC6a+iKDYrkFhi6KY6cl/QnyJ7pdtLP6EICIxd7
I7iHFaspxG853oGHyR5ZTVvUNpik54+psp05eTZ3L9ygPZUF3Dg=
=EimB
-----END PGP SIGNATURE-----

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4--
