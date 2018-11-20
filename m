Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC53C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A416520C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A416520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeKTTRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:17:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50212 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeKTTRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:17:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 88F73207B0; Tue, 20 Nov 2018 09:49:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5A861206D8;
        Tue, 20 Nov 2018 09:49:03 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:49:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v2 08/14] clocksource/drivers/sun4i: register as
 sched_clock on suniv
Message-ID: <20181120084903.v6v2m2sdiwdo34bd@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <6f4773bdef8979bff71e958c9ca2c832c68ada0d.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ccq6ihtnj6zd225"
Content-Disposition: inline
In-Reply-To: <6f4773bdef8979bff71e958c9ca2c832c68ada0d.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ccq6ihtnj6zd225
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2018 at 05:17:07PM +0300, Mesih Kilinc wrote:
> The suniv chip (newer F-series Allwinner SoCs) is based on ARM926EJ-S
> CPU, thus it has no architecture timer.
>=20
> Register sun4i_timer as sched_clock on it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

This one should be squashed in the previous patch.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6ccq6ihtnj6zd225
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PKfwAKCRDj7w1vZxhR
xZs0AQC4o/OwTC3dp3No5ATagHb5YFUOuLUiwQ1qsxZ3wxmTiAD/fXQc5gaCxWxs
gqepN/pnBIA/oNPIjuIgsprcrCM+Bw0=
=B8bk
-----END PGP SIGNATURE-----

--6ccq6ihtnj6zd225--
