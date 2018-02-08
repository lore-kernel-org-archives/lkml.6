Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBHNfN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:35:13 -0500
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:54599
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750961AbeBHNfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:35:11 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] lightnvm: add 2.0 geometry identification
Thread-Topic: [PATCH 3/4] lightnvm: add 2.0 geometry identification
Thread-Index: AQHTnnsLi3QMkLyuBUO/Xbh5ovboWKOahkuA
Date: Thu, 8 Feb 2018 13:35:09 +0000
Message-ID: <EC9FE5B1-5E13-4B4F-A925-07572859FBE9@cnexlabs.com>
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-4-mb@lightnvm.io>
In-Reply-To: <20180205121505.27563-4-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3282;7:Slp36dPmLqOw+NoFDBl/q2GSpfLICVy4ZNNzvixZ25pxISvATRIJdIVsSzG/GP67b4DZklsN4KBnKR9go2GUiTRKJQH7nQ8gkFJunJFrnZlBp+utxGXiOnw1NjhfTKX/x9LR8WXgQ42DQA4PLpZadOwv1zzryNpzo1Hp3AzrkOjWEgrg9Yi/JzfgI/qxUyPJJJ9AC7QPlslvLWI1nP6afWI/Fzd00JLAgSIFynwgkcZWE/Qk5AkAZnRoMrL09Esb
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f7ea42d2-fc7a-48d8-3d7c-08d56ef8c5e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3282;
x-ms-traffictypediagnostic: BN6PR06MB3282:
x-microsoft-antispam-prvs: <BN6PR06MB3282820B5DF372065DEEE56EBAF30@BN6PR06MB3282.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR06MB3282;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3282;
x-forefront-prvs: 0577AD41D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(6436002)(6486002)(6116002)(3846002)(86362001)(106356001)(54906003)(83716003)(316002)(6246003)(3660700001)(3280700002)(99286004)(53936002)(478600001)(6512007)(33656002)(14454004)(6916009)(68736007)(82746002)(2900100001)(8676002)(81156014)(81166006)(229853002)(66066001)(105586002)(5660300001)(186003)(26005)(2950100002)(77096007)(76176011)(36756003)(102836004)(6506007)(8936002)(7736002)(305945005)(4326008)(2906002)(99936001)(25786009)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3282;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: z/7LDwwvjA0f6FQZHmcmI/ceDrprEdq4JMvZVAYhbEidb6P8okXxjwxF72KMQX9NV3YiEZc2/Ozg73oV6s9tbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ea42d2-fc7a-48d8-3d7c-08d56ef8c5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2018 13:35:09.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Feb 2018, at 13.15, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Implement the geometry data structures for 2.0 and enable a drive
> to be identified as one, including exposing the appropriate 2.0
> sysfs entries.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c      |   2 +-
> drivers/nvme/host/lightnvm.c | 334 =
+++++++++++++++++++++++++++++++++++++------
> include/linux/lightnvm.h     |  11 +-
> 3 files changed, 295 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c72863b36439..250e74dfa120 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -934,7 +934,7 @@ static int nvm_init(struct nvm_dev *dev)
> 	pr_debug("nvm: ver:%x nvm_vendor:%x\n",
> 			dev->identity.ver_id, dev->identity.vmnt);
>=20
> -	if (dev->identity.ver_id !=3D 1) {
> +	if (dev->identity.ver_id !=3D 1 && dev->identity.ver_id !=3D 2) =
{
> 		pr_err("nvm: device not supported by kernel.");
> 		goto err;
> 	}
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 6412551ecc65..a9c010655ccc 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -184,6 +184,58 @@ struct nvme_nvm_bb_tbl {
> 	__u8	blk[0];
> };
>=20
> +struct nvme_nvm_id20_addrf {
> +	__u8			grp_len;
> +	__u8			pu_len;
> +	__u8			chk_len;
> +	__u8			lba_len;
> +	__u8			resv[4];
> +};
> +
> +struct nvme_nvm_id20 {
> +	__u8			mjr;
> +	__u8			mnr;
> +	__u8			resv[6];
> +
> +	struct nvme_nvm_id20_addrf lbaf;
> +
> +	__u32			mccap;
> +	__u8			resv2[12];
> +
> +	__u8			wit;
> +	__u8			resv3[31];
> +
> +	/* Geometry */
> +	__u16			num_grp;
> +	__u16			num_pu;
> +	__u32			num_chk;
> +	__u32			clba;
> +	__u8			resv4[52];
> +
> +	/* Write data requirements */
> +	__u32			ws_min;
> +	__u32			ws_opt;
> +	__u32			mw_cunits;
> +	__u32			maxoc;
> +	__u32			maxocpu;
> +	__u8			resv5[44];
> +
> +	/* Performance related metrics */
> +	__u32			trdt;
> +	__u32			trdm;
> +	__u32			twrt;
> +	__u32			twrm;
> +	__u32			tcrst;
> +	__u32			tcrsm;
> +	__u8			resv6[40];
> +
> +	/* Reserved area */
> +	__u8			resv7[2816];
> +
> +	/* Vendor specific */
> +	__u8			vs[1024];
> +};
>=20

All __u16, __u32 should be __le16, __le32

Javier

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp8UgkACgkQIX4xUKFR
nnQCEg//fM0N4+uLOozhUHivEp7vlULcpFYyTJ1lnNit3UuGsSZcFTFeqWMSBBVH
4AitQD7QR+FuB38xugeX7RXHEiyf2HQliCseFPGLpPjUgB012xLCENhmsxWdTNJC
MVJUHJAGWotxAVnYuhgllatDiIquG3HfBRLhIxW07DgFaP3XNMSnD4JcNo+azQgy
bxROK+JNv6Ww/BW3L2zdk1R6c7SIZhf2qf89Fkg+5e/oTYK2YdXSiBNX5lxloA6W
cPVc0jZQ+B1hIUACucfgY4FQroc3kBy3RH6EP5LTbW9YujaTa1kin90FjDywjsjM
g9Wto3ZDmXdCMs1kcpXJSc6mlfElhcveuv4l57dJgFHIIAadAn/CLI1zM29xGqD1
Pwf9tN1J39YZysIAhqNQf9ouF096FUnHthJ+jgS1KWeRLErRm9YiE85vUiL74ONU
4vHHYOn49n6g3vd5GoLE2w85/FkVjo9UoZInxAVSk6CbVg9YAFN6lppF/wuIt8Nw
q1pFBEibHxFv4Wo3QbIj5zP+3pzKAElWrHX08ArHxzNIVPE0WXrGM5p032s+8NsH
DuFl1eH5G17XbXG8yfpQ/WF09oGTX6xZUUf09HcYLn5hGCaFGSXuOY8YDRb+EJy8
L61Co1S5LFL4EHciG8uGi2e8d9SCwlH5qQAQ7eo6O1/CE8germ8=
=rVcv
-----END PGP SIGNATURE-----

--Apple-Mail=_2550ADA7-9B57-4AB8-8C94-2AE842416BB3--
