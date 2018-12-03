Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236DFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDFA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDFA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeLCPp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:45:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44116 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeLCPp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:45:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AD5822087D; Mon,  3 Dec 2018 16:45:54 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 63336208D0;
        Mon,  3 Dec 2018 16:45:44 +0100 (CET)
Date:   Mon, 3 Dec 2018 16:45:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
Message-ID: <20181203154544.6wgtmw533hlfse5c@flea>
References: <20181203154100.4280-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m3a25uo2rjrzvdfp"
Content-Disposition: inline
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m3a25uo2rjrzvdfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 11:40:58PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This small series renames the csi0 and ts0 pin function names to csi and
> ts. This makes the names match the datasheet. As there are only one of
> each type of controller, having a numeral suffix doesn't make sense.
>=20
> I'd like to do the rename now while we don't have users nor support for
> these two controllers. I planned to send this together with CSI support
> for the A64, but Jagan beat me to it, so here it is.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m3a25uo2rjrzvdfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAVPqAAKCRDj7w1vZxhR
xU4yAQDIWgf45b6dSVkYblux94mUY73J0ErcdId2Qr11mORJ2wEA7jFYn4cXLL/9
kpq9p1cELHbJpW8+CvcNLk2jLxzBGAs=
=fMX4
-----END PGP SIGNATURE-----

--m3a25uo2rjrzvdfp--
