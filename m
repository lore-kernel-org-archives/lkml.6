Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289222075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289222075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeIELun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:50:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34970 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:50:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2498D20789; Wed,  5 Sep 2018 09:21:52 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id E4B1A206F6;
        Wed,  5 Sep 2018 09:21:51 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:21:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 07/11] dt-bindings: clock: sun50i-a64-ccu: Add
 PLL_VIDEO0 macro
Message-ID: <20180905072151.3jqfpzuawyohov3f@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3gzuf2gmgk6626l"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-8-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3gzuf2gmgk6626l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:49PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>=20
> Allwinner A64 HDMI PHY clock has PLL_VIDEO0 as a parent.
>=20
> Include the macro on dt-bindings so-that the same can be used
> while defining CCU clock phandles.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t3gzuf2gmgk6626l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPhA4ACgkQ0rTAlCFN
r3QDQxAAj7mPvzsiH5fbSmjgQ+8ntWeBcT2+HPD+cPwtc6eSLNzjFBYEGmmp1yge
ek+tHfSqaNNaSMv8DDRoOX24hYCwJEyZSlLM9nJ67X6v71eWKV6eIYStA7NeWYfZ
FNIp+aF++6eKkTlDa+ouyh/z3nsbcJ/yWcD9FFoISfCNCL3InlmRRh/9vTHUBabU
AHprK7P0m3YICEbKjDw0Vnm6zYptLn5RcHSCFWRi0i6fk/XTzovp8+w0qzaxygK5
ivkgBM9mBI6KZhCBq3Laf/OHe/cL/bERYX52N2fcdFhQNroT/IaR8EW5+zvBm8/b
Z0gzgblz62E0qHIvPwdpT/5JJksezmZQPbXvNRi5TUFri+dsVZ/VBjp1MefgiLqC
Yv+rz9OuXA9rC7ql57/lznqmvSfygH+SjNdoFkRgj47gdDpX02nEMVn/MHkeW3WU
K+0ZHMtiWEhc2YySEZngBfC4UyR1cl6teD6d+lVamfl98V/LlthWF8MaVlllBM1y
YKdXVQ9lSJr1IzAddN10ca6oQVbnJAHUBoVMMqw/L2ep83OaJ39sXXrI4Y3CELIJ
6Jc0Xo6M1f07aO9vccecsN7gHeqLctnxesUR/QOSEaoRAUbSDYhC37TzPjAAO+nO
JuV68cT2too0edp4bDMK4OqxM8lVGWDbjCGfPAc89wGYM1pTv0A=
=TGu8
-----END PGP SIGNATURE-----

--t3gzuf2gmgk6626l--
