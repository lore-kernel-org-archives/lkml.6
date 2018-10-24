Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1BDECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383620838
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F383620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJYCmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:42:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52832 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYCmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:42:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E8D67208C7; Wed, 24 Oct 2018 20:13:44 +0200 (CEST)
Received: from localhost (unknown [2.223.63.88])
        by mail.bootlin.com (Postfix) with ESMTPSA id AAA8020890;
        Wed, 24 Oct 2018 20:13:34 +0200 (CEST)
Date:   Wed, 24 Oct 2018 19:13:34 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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
Subject: Re: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for
 PLL_MIPI
Message-ID: <20181024181334.lul7ta7ijluwfb7v@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqw3vje525gqrsp3"
Content-Disposition: inline
In-Reply-To: <20181023155035.9101-13-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqw3vje525gqrsp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 09:20:32PM +0530, Jagan Teki wrote:
> A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> using minimum 500MHz can't release the clock and which
> is not working.
>
> So use working minimum rate as 300MHz which is tested on
> Bananapi DSI panel.

I'm not quite sure what you mean by that. What do you mean by "500MHz
can't release the clock"? Why would 300MHz work better then? Should be
avoid reaching 500MHz if it's a frequency in the valid range?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bqw3vje525gqrsp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9C2TgAKCRDj7w1vZxhR
xRk5AP9l8gJcTk3NRkPKMtYP8PiTTLkMKZDifHCACpchw6KSEgD+Ip4W0VWvyICR
hnTLjoVBjGzX3A4swj5luUG0JfnWRQo=
=4oPG
-----END PGP SIGNATURE-----

--bqw3vje525gqrsp3--
