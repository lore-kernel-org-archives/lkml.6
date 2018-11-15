Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D759DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8A22086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8A22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbeKPB0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:26:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46082 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeKPB0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:26:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AE5920893; Thu, 15 Nov 2018 16:18:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E83620379;
        Thu, 15 Nov 2018 16:18:13 +0100 (CET)
Date:   Thu, 15 Nov 2018 16:18:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     hao_zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, icenowy@aosc.io,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v0 0/2] Initial Allwinner T3 support.
Message-ID: <20181115151813.a27uov3zmgzjcerf@flea>
References: <20181114082033.GA20712@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvncl5mqd6ujkb6d"
Content-Disposition: inline
In-Reply-To: <20181114082033.GA20712@arx-s1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvncl5mqd6ujkb6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Nov 14, 2018 at 04:20:33PM +0800, hao_zhang wrote:
> Initial Allwinner T3 support.
>=20
> Allwinner T3 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU, and a
> Mali400 MP2 GPU from ARM. It is a not-pin-compatible quad core sucessor
> of the A20). It's also known as the Allwinner R40 for In-Car
> Entertainment usage.

That series looks good, thanks!  The only thing that would need to be
reworked is your Signed-off-by name, which (I guess?) should be
written the same way than in your Copyright info.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mvncl5mqd6ujkb6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+2ONAAKCRDj7w1vZxhR
xQdUAQCoTnk08hPOnNMruKvlcsB2v+Ne12xovty1crHmW1lKtAEAv3DNySkDqyXG
UgiSFeMoSZUkSvOM/q0adyh/uaMs1gU=
=/VB7
-----END PGP SIGNATURE-----

--mvncl5mqd6ujkb6d--
