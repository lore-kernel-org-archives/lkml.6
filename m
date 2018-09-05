Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC432075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC432075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIELhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:37:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33964 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIELhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:37:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C071B20766; Wed,  5 Sep 2018 09:08:20 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 95DFA206F6;
        Wed,  5 Sep 2018 09:08:20 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:08:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: Re: [PATCH v4 4/4] drm/sun4i: Enable DesignWare HDMI for SUN50I
Message-ID: <20180905070819.gisznpkvvuqire7c@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dalurjfys7j4k4zw"
Content-Disposition: inline
In-Reply-To: <20180904163609.10171-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dalurjfys7j4k4zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 10:06:09PM +0530, Jagan Teki wrote:
> Allwinner SUN50I are now using DesignWare HDMI so enable
> them as default. This can build DRM_SUN8I_DW_HDMI as module
> since DRM in arm64 has module.
>=20
> Making this as defult to SUN8I, may cause an issue while
> loading since arm32 DRM built as static.

Uh? Why? We should fix this instead of working around it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dalurjfys7j4k4zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPgOIACgkQ0rTAlCFN
r3SxWg/+Psm2VdDssaS2hlPN8yqt6NwxWzfVgyg51qEsdyGMD4+d3TR+10iXfnM+
rzH076iYp0ZBKFJ1ehkLhfW7/RLOPHY18H8MVPckjde6BhRlTtqOfc3lBtCwxkxt
rYMidQMOij0+w4sFtv98gcdtozfbz8y9PorSpVreJj2lkA9DonTTbX44h0JTLJLQ
DpvBdliDCkDxRDzrnGgcWhVqOsCuw5FtaLcGaA8Mh2Gx5AAUz4b8pPMmhV8zZWxO
pdTW3da3YReUwbQs40BI4z3w6m5tQ3p3puDWQU/js34Ihi83mqzQO7Nb7rNFsnHB
QCK9RtzdaTYm9XhC+0WqHmltn3LKlJJqTM6p5Nstx9rycAHqCzcWpYYzR6JES6rK
tKz0u2+p15I3piA9lB95G+qgqJMXO5VhIAMVS+IuPa0sttLFPPS2DKy4cEKvSoto
3PUpz8z9n2j8wlr6hT4dYOOLkA4nyVBwHZ4hXrakyy65/1gMB2VXNzzna7GWfY1B
+zH7EJ0W1WI4Qd0bk2dXERAkcGW1JhyStWD13udnTratz/51EEAx1pOVV4tAOPEL
PyRyGdAVfe5ycUP2g8J+n3rdi+NKaztoqhfSJhIkNzdog8eO3VUuCCj8FbFtAIQX
43zurL9W0rCt5MSU3raho3Dwo3Ju1FX8r40sa95QSHLA1KHo2sM=
=SQ9C
-----END PGP SIGNATURE-----

--dalurjfys7j4k4zw--
