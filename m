Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9191C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B15D2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIELdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:33:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33590 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIELdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:33:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 21C9F20756; Wed,  5 Sep 2018 09:04:52 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id E8888203DC;
        Wed,  5 Sep 2018 09:04:51 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:04:51 +0200
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
Subject: Re: [PATCH v4 2/4] arm64: defconfig: Enable CONFIG_DRM_SUN4I
Message-ID: <20180905070450.b5vgp7j65rxwipno@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hqpjwkk3omedglce"
Content-Disposition: inline
In-Reply-To: <20180904163609.10171-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqpjwkk3omedglce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 10:06:07PM +0530, Jagan Teki wrote:
> Enable DRM Support for Allwinner Display Engine, built as a module.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hqpjwkk3omedglce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPgBIACgkQ0rTAlCFN
r3Rq2A/+ImLadBwx7TydpMue7SKkyPHCj139z7GMa7vUG7MdKdXwtAasZ1UC1YUJ
0GZ5wy4aoZzyCU9UkAOkhvlYlqafJf012lRjWE6ur8ngQXMKx4ab3Y58FsidDFLw
Kium5oBMCY5PVn7ICNg7uz+Dci4jFm8tWJKATWfSQFG4j8/R4fdz9tRh+B5la6jf
pCy4wjnQMvQFpCH5qibod3imfCXsobuLAoy3frkEPc8drK9xtyArpwgbnxt19v/N
7RytTTMFVjtXM53Mt/2QK7goYkQ53cKKzA76QP1bnVelCgRicfIRHxpLc/F39woj
afR1tzblrZkintiN2aeNxC2xEbvMQkXfYapwdO0yWyQekEz8+uXnTMJZxPdk++DY
mRIv6KRUoUAUjkKfkOwRgPiJQPzNeU5cDZ7SI4hQOiA/rxJBRdMglOdeW7HmGHiW
Yp9+Rv1vIFNiPTuOSRU5+ArU5qBXnlwVyqSY04+dgpiRfq/IMkGxr/GwDBpAPGPZ
7+P8TU9PoO8sYocWCc+meSYsqYNQVB4gM1McTJtq3/Yu8Seuk59wgE0E24x0456b
GU6oWVRqk9eDkR5dMI7RZB8BWaGsFWZAKMr1OhRazw9x9NdTInVIX4SzMa0y3KXT
3945mcrI0xGblygMojeDo60REp/kcqxGzacScBzJhNVBbqMBXbc=
=pBnJ
-----END PGP SIGNATURE-----

--hqpjwkk3omedglce--
