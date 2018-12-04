Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078EA2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078EA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeLDJMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:12:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48119 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbeLDJMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:12:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 41E6120A66; Tue,  4 Dec 2018 10:12:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E08A20723;
        Tue,  4 Dec 2018 10:12:04 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:12:04 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
Message-ID: <20181204091204.jtzk5gf2clumjwiq@flea>
References: <20181204090457.15597-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ntukseib6hpdpxly"
Content-Disposition: inline
In-Reply-To: <20181204090457.15597-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ntukseib6hpdpxly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 05:04:57PM +0800, Chen-Yu Tsai wrote:
> Pin PH11 is used on various A83T board to detect a change in the OTG
> port's ID pin, as in when an OTG host cable is plugged in.
>=20
> The incorrect offset meant the gpiochip/irqchip was activating the wrong
> pin for interrupts.
>=20
> Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller s=
upport")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ntukseib6hpdpxly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAZE5AAKCRDj7w1vZxhR
xXA2AQCPFSIvJF22brGFxdzkEfvHrhtpFPzoHoLkoheaIv9R/AD/Rc/ipWK1MMF5
jlxe58eaPCjXuyKYlx9iEdfyF7/CRA8=
=b4P4
-----END PGP SIGNATURE-----

--ntukseib6hpdpxly--
