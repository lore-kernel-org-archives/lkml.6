Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B724720660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B724720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeK1VVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:21:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47109 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbeK1VVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:21:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 03BC7206D8; Wed, 28 Nov 2018 11:20:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 18394207BD;
        Wed, 28 Nov 2018 11:19:06 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:19:06 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 02/15] dt-bindings: rtc: sun6i-rtc: Add compatible
 strings for pre-H6 variants
Message-ID: <20181128101906.xkqaoezxodz25c3x@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="564j2t6jjeonxwuc"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-3-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--564j2t6jjeonxwuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:29:59PM +0800, Chen-Yu Tsai wrote:
> While doing Bluetooth enablement for various boards based on various
> Allwinner SoCs, minor differences in the RTC modules were found. These
> include a lack of an external clock output (A31), different internal
> oscillator frequencies (H3/H5/A64/V3/V3s), different regulator voltage
> settings (H5/H6), and the presence of miscellaneous registers unrelated
> to the RTC (A64/R40/H5/H6). The datasheet also describes different number
> of registers for non-volatile storage, though based on actual experiments
> the actual number is the same across the board.
>=20
> This patch adds a list of all pre-H6 variants, grouped by the internal
> oscillator's clock rate, regulator settings, and the presence of the
> external clock output. Combinations are introduced for the variants that
> have miscellaneous registers.
>=20
> The RTC block in the H6 also handles the 24 MHz DCXO. This will require
> more device tree binding changes and will be done later.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--564j2t6jjeonxwuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5rmgAKCRDj7w1vZxhR
xa1GAQCglQwtyy6YC53hEhaGjYC8rh4XPC4fW30urBIm/jOMPwEA1GGhJq2nWeGG
Wn3Bdqj1P0UFNPamrR4GmRObi8AfAwk=
=jNdp
-----END PGP SIGNATURE-----

--564j2t6jjeonxwuc--
