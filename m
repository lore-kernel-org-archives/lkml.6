Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02845C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0BE2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0BE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIETKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:10:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52076 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeIETKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:10:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B200120789; Wed,  5 Sep 2018 16:39:43 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 840DB2071E;
        Wed,  5 Sep 2018 16:39:33 +0200 (CEST)
Date:   Wed, 5 Sep 2018 16:39:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
Message-ID: <20180905143932.lbytjftmobjtzdsu@flea>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
 <20180905071435.lgsogpzmh5nw6bcy@flea>
 <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
 <20180905075601.32kzkd3is2gpa3ft@flea>
 <1CE38B34-005F-4E49-B9B5-48EDFA56EFE5@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gnyepzpdeoujvh6"
Content-Disposition: inline
In-Reply-To: <1CE38B34-005F-4E49-B9B5-48EDFA56EFE5@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6gnyepzpdeoujvh6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 04:05:18PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B49=E6=9C=885=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:56:01, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Wed, Sep 05, 2018 at 03:46:41PM +0800, Icenowy Zheng wrote:
> >>=20
> >>=20
> >> =E4=BA=8E 2018=E5=B9=B49=E6=9C=885=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=883:14:35, Maxime Ripard
> ><maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >> >On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
> >> >> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
> >> >> introduced in R40, although it has two PLL-VIDEOs.
> >> >>=20
> >> >> Change the A64 HDMI PHY binding to R40 one.
> >> >>=20
> >> >> This binding is introduced in v4.19, which is still in RC stage,
> >so
> >> >we
> >> >> have change to fix it.
> >> >>=20
> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >
> >> >That doesn't make much sense. The A64 doesn't have any particular
> >> >reason to behave like the R40, and the R40 can definitely use a
> >> >different compatible if it has a different behaviour. But I don't
> >see
> >> >*why* the A64 not behaving like the R40 is a justification to remove
> >> >the A64 compatible. Especially when the R40 was released later.
> >> >
> >> >Add a new compatible, and leave the A64 compatible alone.
> >>=20
> >> But the behavior of A64 compatible will change from double
> >> PLL to single PLL, because the A64 HDMI PHY is proven
> >> to have no double PLL.
> >>=20
> >> Should I then change the A64 compatible behavior and import R40
> >> compatible at the same time?
> >
> >I don't see why you should do both at the same time. Fix the A64, and
> >add the support for the R40, those are two orthogonal changes.
>=20
> Then how to deal with double PLL support? Make them temporarily
> dead during 4.19?

Well, if the PHY doesn't use two PLL, don't use it, ever. Why does it
have to be temporary?

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6gnyepzpdeoujvh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluP6qMACgkQ0rTAlCFN
r3SO+Q/+JI6BwCnKyImFVIb5OvNNBW/n41sBO4VohMeGozJZm9cVbn2acA5UJ4uF
26AJTiB75J0wgDpvPtYponwyxlUnoo5CPRmaJyj/4Q8W825gMZ+0ZTWjzsWJTM0B
9Dl8la7r5HulmUSvGfrQarFbfxERVHxMjmCStHjFM6jLvyMx6cS4/0WMbTqDX9bp
Rw0ogYCohlSRXgRNolzIRc/7eEIRgnvIwoBYLrVfwRm8J11xlibWSdgFCWhJckb/
VOl9VjstWCCS99++Hm3XBPysp/mSDMHC76itheWzICqYRCAAdsuydADttyYElpW4
gBCNf875cAlusnhsmSVu8c6ZnszffzXvtk7RIftJsFOS7nVX5eUTyBhRVZBGMnkx
xzusuIFz4M+d2wEP++vnhPi3IOgB+vAudfy1RLGdV6kyad8h/pG08GBSwBIaD5se
RVpnPsiuUrOkRs4UFUHV/k3TSTytN/qLXNQ5htd7+6REfRiydtgQ6S84MMhFtZWb
hClYSlJGNbUaFH8gndTky/DnoFZjtqAgnPFb9q1PWlMGF4SeauYrd7oQqRIDgQin
M8kErYpfVh0bOKpsAShEsfMgopzqGL3vqMiA3GlpSNMCsZbvV+e/bA34G9Szf+5c
X/081AM3Z4qJsHBmnCsrRjl+ZR90wzA6F+PRbGvpkm3dgKH22SQ=
=giSw
-----END PGP SIGNATURE-----

--6gnyepzpdeoujvh6--
