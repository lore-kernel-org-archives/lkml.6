Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116F20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8116F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeGQPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:53:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeGQPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:53:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 372E620798; Tue, 17 Jul 2018 17:20:03 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0499B207AB;
        Tue, 17 Jul 2018 17:19:53 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:19:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sunxi: Remove unused address-cells/size-cells
 of dwmac-sun8i
Message-ID: <20180717151953.oab5tsurldmz4tjn@flea>
References: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rpucpdbcayeuqohf"
Content-Disposition: inline
In-Reply-To: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rpucpdbcayeuqohf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 11:55:49AM +0000, Corentin Labbe wrote:
> address-cells/size-cells is unnecessary for dwmac-sun8i node.
> It was in early days, but since a mdio node is used, it could be
> removed.
>=20
> This patch fix the following DT warning:
> Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary=
 #address-cells/#size-cells without "ranges" or child "reg" property
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
>  arch/arm/boot/dts/sun8i-a83t.dtsi                     | 2 --
>  arch/arm/boot/dts/sun8i-r40.dtsi                      | 2 --
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                    | 2 --
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 --

Just saw this, and dropped the patch. Please provide separate patches
for the h3-h5 DTSI, the arm64 and arm patches.

And ideally for the binding.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rpucpdbcayeuqohf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltOCRgACgkQ0rTAlCFN
r3SDUA/+KoqMRtH+8qiShINYT6bdZ50fqD3lWLEOecicnlMuUWLdfgwrnsd3uLHC
ZmN/4d06AW5YDyIWtnblv0O6Mc+pgWyhFm/0+DJk5Qv6j2ObOAw5HC5mtPOr66dE
ewA+nU52dGz8f9B6ZgpknuF22I6EJTeftcWllQLy3zknqprEQtWY/WrA7LhLX726
uq/gNo8nd+Qv1X4H8ZzLK1mLTL9R+AktjluD7QSZ/hYghsZDvrz3rkEQsINEmn0+
ePIqxlp34jZTpopVr4dc9GfYDpuguTZcMI2F+YNbe6ZPC7LFHvUoZmobFYozJhSR
y/QiGjFKrjKLNmvQPuXqOlyTJJD5SFh45kOQjtg15SeXq3XyCzsLTsCmXBcmmlT8
UX3/yg1rxTyMuvyFhrggOdHUBcyug/EfKgneiFCHil0GJMQVbQ/7xDkUJesto5MV
zFu+L+B3toHBQ29qIgXcrxc/eESaRwDGj0j2FOD01FQhxPvpMdrGYH3NgY6SAgGA
Pn9++BW+INpIDQO0HQcTeRLTw+8yN4fYwo2bsnn8jn4UxuDgp5dM8cqfkCmLm+SK
brGHfUqKCbr5cs0AvEBn3ReP68MSC6r9sT3ZREHjV1DTjhZMWui6S7o/fSqH2qAz
AjXqOvzsDNbXF3bV0SAGWP5Yl4WrsgDu7nmIFB6bRG1e4H03V9g=
=JwA9
-----END PGP SIGNATURE-----

--rpucpdbcayeuqohf--
