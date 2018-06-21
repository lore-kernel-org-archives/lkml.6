Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C345BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeFUOaQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:30:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932628AbeFUOaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:30:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F168C20798; Thu, 21 Jun 2018 16:30:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB6372075D;
        Thu, 21 Jun 2018 16:30:02 +0200 (CEST)
Date:   Thu, 21 Jun 2018 16:30:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        linux-media@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: drivers/media/platform/cadence/cdns-csi2tx.c:477:11: error:
 implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
Message-ID: <20180621143003.2tr7lsexsj7mcbzm@flea>
References: <201806180714.gwQUkLIy%fengguang.wu@intel.com>
 <0e6e7b2a-1624-4c15-85ff-3796e0104a3b@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gzgeorpabunm4bd7"
Content-Disposition: inline
In-Reply-To: <0e6e7b2a-1624-4c15-85ff-3796e0104a3b@infradead.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gzgeorpabunm4bd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi randy,

On Wed, Jun 20, 2018 at 04:02:00PM -0700, Randy Dunlap wrote:
> On 06/17/2018 04:29 PM, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   ce397d215ccd07b8ae3f71db689aedb85d56ab40
> > commit: 6f684d4fcce5eddd7e216a18975fb798d11a83dd media: v4l: cadence: A=
dd Cadence MIPI-CSI2 TX driver
> > date:   5 weeks ago
> > config: x86_64-randconfig-s5-06180700 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout 6f684d4fcce5eddd7e216a18975fb798d11a83dd
> >         # save the attached .config to linux build tree
> >         make ARCH=3Dx86_64=20
> >=20
> > All error/warnings (new ones prefixed by >>):
> >=20
> >    drivers/media/platform/cadence/cdns-csi2tx.c: In function 'csi2tx_pr=
obe':
> >>> drivers/media/platform/cadence/cdns-csi2tx.c:477:11: error: implicit =
declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=3Dimpli=
cit-function-declaration]
> >      csi2tx =3D kzalloc(sizeof(*csi2tx), GFP_KERNEL);
> >               ^~~~~~~
> >               vzalloc
> >>> drivers/media/platform/cadence/cdns-csi2tx.c:477:9: warning: assignme=
nt makes pointer from integer without a cast [-Wint-conversion]
> >      csi2tx =3D kzalloc(sizeof(*csi2tx), GFP_KERNEL);
> >             ^
> >>> drivers/media/platform/cadence/cdns-csi2tx.c:531:2: error: implicit d=
eclaration of function 'kfree'; did you mean 'vfree'? [-Werror=3Dimplicit-f=
unction-declaration]
> >      kfree(csi2tx);
> >      ^~~~~
> >      vfree
> >    cc1: some warnings being treated as errors
>=20
> From 2018-06-08:
>=20
> https://patchwork.kernel.org/patch/10455245/
> or
> https://marc.info/?l=3Dlinux-kernel&m=3D152849276709302&w=3D2
>=20
> I marked it as for linux-next, but it does need to be applied to mainline.

This was fixed some time ago by Arnd, and the PR has been sent today,
so it should reach Linus some time soon:
https://patchwork.linuxtv.org/patch/50464/

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gzgeorpabunm4bd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsrtmoACgkQ0rTAlCFN
r3QU+g/+Lr+GCKbzeQsRfpxai7Te5Nt83qB5K7PLnes4ecOBzoQ+3Yolr3lWGz++
7TmCXyMeal67qUaoIWiHVvy9u2q/Bm0cNjYM6quJwMem844SgilMOqV8PHZ5Hhfa
gZORPgHrIDr1iQ9sULe+J2PV3lqCmXKK5g8fy+L9dJe2aYyYruyo9Aqe+cU7qiJx
/3DAEw0pLkOTf1P4aWqsD38mLdgHDa4SXp5RBnp1d1EmX5oaBMY7CiD2nqzY2EwF
lvBTAgwMXXUTUx7nXGHKuCG5MazjyIOtKcuNynfrnwHVnuqflNT4KOTBf174RFfY
5vmy7Jq0LToO0gv8K4ZM6XhqUw81E0PCXDEzRk8YJFx0RU0xiBN0XjhSqc/RVRzc
AsloFNmPXFTxCAErVf9v8LOzqSbEBZrUrEAGEq5oZNtmlzbiZ5BIS4oJCW3FKTcj
3E9KHPauCQKIPh9Za0XekFGJnp8+4CiJFKdt2uU8z8fBBKpoGbSb7wfpPm1eEeGm
iK01LauPSVh+C4IwkKhWGvDCcZ3ZZh2QybXGOcZXU+lhYLqikKhf5uhDQgjuM2zM
OpBivOuBOCVHJmkRvyKyShhtbZfyxinqqhNczakSUVgJe2mn5WR8lhXa3t46tQ06
EywTH1t4ttj220M5ByXsYu49CSWXOJkL2QVi+4AfASdVLG5oj5Q=
=RLXn
-----END PGP SIGNATURE-----

--gzgeorpabunm4bd7--
