Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56867C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeKHR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:59:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56898 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHR7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:59:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7FC1A2072B; Thu,  8 Nov 2018 09:25:22 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4E44D2039F;
        Thu,  8 Nov 2018 09:25:22 +0100 (CET)
Date:   Thu, 8 Nov 2018 09:25:22 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] arm64: dts: allwinner: a64: bananapi-m64: Add
 Bluetooth device node
Message-ID: <20181108082522.va5c63sb6t7zphpm@flea>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-16-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t6s7uuse6hpustnp"
Content-Disposition: inline
In-Reply-To: <20181107101308.7626-16-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t6s7uuse6hpustnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 06:13:08PM +0800, Chen-Yu Tsai wrote:
> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
>=20
> The Bluetooth side is connected to UART1 in a 4 wire configuration. Same
> as the WiFi side, due to being the same chip and package, DLDO2 provides
> overall power via VBAT, and DLDO4 provides I/O power via VDDIO. The RTC
> clock output provides the LPO low power clock at 32.768 kHz.
>=20
> This patch enables Bluetooth on this board, and also adds the missing
> LPO clock on the WiFi side. There is also a PCM connection for Bluetooth,
> but this is not covered here.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks for figuring this out!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t6s7uuse6hpustnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+Py8gAKCRDj7w1vZxhR
xUgMAP4lHNDeIzOp3J20omQfW/bPd7gZ0PgIz/e7MAMMc8pA9AEAsv3ov2TDVct8
KYP4cZOMtGjNuTD31VJ2Kk6t0NyF0AQ=
=Yjo9
-----END PGP SIGNATURE-----

--t6s7uuse6hpustnp--
