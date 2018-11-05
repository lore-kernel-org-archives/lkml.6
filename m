Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F52081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371F52081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeKFAn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:43:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45655 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeKFAn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:43:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E012E207F4; Mon,  5 Nov 2018 16:23:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id ACBEC206D8;
        Mon,  5 Nov 2018 16:23:03 +0100 (CET)
Date:   Mon, 5 Nov 2018 16:23:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@openedev.com>
Subject: Re: [PATCH v2 3/3] arm64: allwinner: h6: Add OrangePi Lite2 initial
 support
Message-ID: <20181105152303.pcpq4btw5ecwzs2y@flea>
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
 <20181105074842.21988-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnzi6de2xx25sdpp"
Content-Disposition: inline
In-Reply-To: <20181105074842.21988-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnzi6de2xx25sdpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 01:18:42PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@openedev.com>
>=20
> OrangePi Lite2 is Allwinner H6 based open-source SBC,
> which support:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 1GB LPDDR3 RAM
> - AXP805 PMIC
> - AP6356S Wifi/BT
> - USB 2.0, USB 3.0 Host, OTG
> - HDMI port
> - 5V/2A DC power supply
>=20
> Signed-off-by: Jagan Teki <jagan@openedev.com>

Applied patch 2 and 3, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jnzi6de2xx25sdpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+BgVwAKCRDj7w1vZxhR
xfR7AQDBBqqSfs/PLONdJJVfyfe8JmGP1kDz6HHGITLRaXVB5AD/d0pyx3oyFWAO
z9flwRTvmNGVGm2Imf6QqiWi932mqwk=
=0dbU
-----END PGP SIGNATURE-----

--jnzi6de2xx25sdpp--
