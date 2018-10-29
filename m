Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A84C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E0920827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E0920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeJ2SVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:21:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56646 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbeJ2SVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:21:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8A14A208CE; Mon, 29 Oct 2018 10:33:16 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 59213207D4;
        Mon, 29 Oct 2018 10:33:06 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:33:06 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 18/25] drm/panel: Add Bananapi S070WV20-CT16 ICN6211
 MIPI-DSI to RGB bridge
Message-ID: <20181029093306.ysyfgnrozbo2ywcu@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-19-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hdtvfuanrelpecuc"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-19-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdtvfuanrelpecuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:37PM +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge
> panel which can be used to connect via DSI port on BPI-M64 board,
> so add a driver for it.
>=20
> The same panel PCB comes with parallel RBG which is supported via
> panel-simple driver with "bananapi,s070wv20-ct16" compatible.
>=20
> BSP dclock of 30MHz is not working with existing sunxi-ng and sun4i
> sun4i_dclk_recalc, so updated to 55MHz can result proper working
> nkm dividers.
>=20
> dclock, 30MHz =3D> PLL_MIPI, 300MHz =3D> set rate 440MHz with 1,2,1 nkm
> dclock, 55MHz =3D> PLL_MIPI, 300MHz =3D> set rate 330MHz with 5,2,9 nkm

That panel is generic, you don't need those details in your commit log.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hdtvfuanrelpecuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bT0gAKCRDj7w1vZxhR
xUQ8AP9YdRaccCX4pK7kzdP4KTovwRcg2mcNR6cZqeZM5zgHBAD8DPHFmJ01ST/h
UbLtUvbCKLNiymS3lObWE6Qelee2ZAY=
=qgcV
-----END PGP SIGNATURE-----

--hdtvfuanrelpecuc--
