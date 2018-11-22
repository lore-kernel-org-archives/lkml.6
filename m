Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFEDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADEA20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADEA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393093AbeKVTPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:15:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46154 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeKVTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:15:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CDB2A20F45; Thu, 22 Nov 2018 09:36:42 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 256C920510;
        Thu, 22 Nov 2018 09:36:15 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:36:15 +0100
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
Subject: Re: [RFC PATCH v3 07/17] clocksource: sun4i: add a compatible for
 suniv
Message-ID: <20181122083615.2ksgpvmfllbqnfiu@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qqjbx4ddugpjz3t"
Content-Disposition: inline
In-Reply-To: <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qqjbx4ddugpjz3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:30:40PM +0300, Mesih Kilinc wrote:
> The suniv (new F-series) chip has a timer with less functionality than
> the A10 timer, e.g. it has only 3 channels.
>=20
> Add a new compatible for it. As we didn't use the extra channels on A10
> either now, the code needn't to be changed.
>=20
> The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture ti=
mer.
>=20
> Register sun4i_timer as sched_clock on it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7qqjbx4ddugpjz3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZqfwAKCRDj7w1vZxhR
xSc9AQDy7vevSc1TqZHYdrxew4ZSz0viOPPLIYhH3CGaYunlcQEAmtsGcSow2XC6
iv324GgkD2lVt8EsC4zp8h/XUHNILAY=
=CpZi
-----END PGP SIGNATURE-----

--7qqjbx4ddugpjz3t--
