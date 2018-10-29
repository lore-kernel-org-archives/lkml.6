Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154CC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A7F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A7F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeJ2SDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:03:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55242 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbeJ2SDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:03:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D7EB320791; Mon, 29 Oct 2018 10:15:17 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id A26992099B;
        Mon, 29 Oct 2018 10:15:07 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:15:08 +0100
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
Subject: Re: [PATCH v3 00/25] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20181029091508.gyhn2m5fnbucvb34@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="36y45ohgmtyd7cei"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36y45ohgmtyd7cei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:19PM +0530, Jagan Teki wrote:
> This series fixed the issues related to work DSI on 2-lane panel
> which is reported on previous version[1].
>=20
> Few comments from previous version still in discussion, but I just
> send this version just to group all working changes together.
> anyway I will fix in this in next version if any.
>=20
> PLL_MIPI min rate is still weird, I tried many possible dclock rate
> from panel driver to satisfy manual suggested min rate 500MHz but
> none working so eventually moved 300MHz. any inputs on this area
> are welcome.
>=20
> All these changes are tested in 2-lane, 4-lane MIPI-DSI panels.
>=20
> If anyone wants to test, use this repo [2] with WIP-A64-DSI branch.

A changelog would be nice here, and usually you shouldn't send a new
version while there is ongoing discussion on the previous version.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--36y45ohgmtyd7cei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bPnAAKCRDj7w1vZxhR
xc3TAPsGM9mbbgPEbeemnJdAp3i8+8IXWkv2qSQ+xPuWMuQo1AD/erFiP6S+Y096
5le9/Ejs/zgE90IGY1rjAwpBliviFgs=
=aut5
-----END PGP SIGNATURE-----

--36y45ohgmtyd7cei--
