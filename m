Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EFEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966952154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966952154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeHTQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:49:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41146 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbeHTQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:49:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3E3F20711; Mon, 20 Aug 2018 15:33:27 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 767C92069C;
        Mon, 20 Aug 2018 15:33:17 +0200 (CEST)
Date:   Mon, 20 Aug 2018 15:33:18 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
Message-ID: <20180820133318.pgkyoajf7il7o4e2@flea>
References: <20180730115223.14161-1-diego.rondini@kynetics.com>
 <20180803075625.13289-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zd7a7kldtq2qaeib"
Content-Disposition: inline
In-Reply-To: <20180803075625.13289-1-diego.rondini@kynetics.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zd7a7kldtq2qaeib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 09:56:25AM +0200, Diego Rondini wrote:
> Orangepi Zero Plus 2 is an open-source single-board computer, available i=
n two
> Allwinner SOC variants, H3 and H5. We add support for H3 variant here, as=
 the
> H5 is already supported by sun50i-h5-orangepi-zero-plus2.dts.
>=20
> H3 Orangepi Zero Plus 2 has:
> - Quad-core Cortex-A7
> - 512MB DDR3
> - microSD slot and 8GB eMMC
> - Debug TTL UART
> - HDMI
> - Wifi + BT
> - OTG + power supply
>=20
> Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>

queued for 4.20

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zd7a7kldtq2qaeib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6wx0ACgkQ0rTAlCFN
r3RNWw//Q76dTBM1NpAlZgqGJg1p3+sF+mQkj0YBXTnRogF3im445GnwhH3ZTfpH
7d+HCuDC9toQEl+4qBiigCsOxNpaYK6ga9Jcy7QiMLhuHnuOcVeKBseI3Kc7oX/S
8jDk8S/ZUrMwGO33E0vLCVg698twsfAOG9S2oL95e1fN4nJMOb0jU6z+KC6KdhlX
cQpq6vWbKfk7wDfiiblkVHVAExbZSchjoV74K7rg77dJ0Yf3TN7Zw5GeCz2O8EWE
by4oKfCfRexfYlIqkFf01BVASrssW8uusnj7T6aJRd2J5cq3RhyEnKK4U7aFfFrb
O2IBlkhjHMSx3ZIn6M/33yRDrppoJxymBHzvigtoWbWZKhZFRYHLliJnQQXft3TH
9An5d122pPUVJJ8sQFcaHbcbqXiw5skGPq788ast+09eEEg4tjn23ewIg4f4kTOR
acXVE/UbZmnJalTzacLf0E0qZZSfAn3IMW+WEty86uCDkfOUAK4VqMZDulAsGDZ0
FcNgjVne2iF7ym47qqtK57FsHNEK8xVRMa/fGK8hixaco5+owXnTpXco1BexNshU
wqJnllkhEORtU7+w8O3XFP0WIDa/FX8EztmmZ/8UimW1KI/+tkSNsJjoGQvgW77k
QiupoXGGNrX8VzUxtn4g5pCgI9PLNkGt9E/WWZTpg2HlICa0g7o=
=u+2q
-----END PGP SIGNATURE-----

--zd7a7kldtq2qaeib--
