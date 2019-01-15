Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD92C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CB520645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfAOP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:57:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56825 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbfAOP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:57:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D61A20A2E; Tue, 15 Jan 2019 16:57:01 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
        by mail.bootlin.com (Postfix) with ESMTPSA id DAD9B20A32;
        Tue, 15 Jan 2019 16:56:50 +0100 (CET)
Date:   Tue, 15 Jan 2019 10:52:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix a typo
Message-ID: <20190115095228.kwhgtumqcechpr5j@flea>
References: <20190113161413.14654-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mochvrg5c7cnhkly"
Content-Disposition: inline
In-Reply-To: <20190113161413.14654-1-j.neuschaefer@gmx.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mochvrg5c7cnhkly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 05:14:13PM +0100, Jonathan Neusch=E4fer wrote:
> This typo inverted the meaning of the comment, but the rest of the
> comment and the code reveal that the regulator in question needs to be
> on at all times.
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mochvrg5c7cnhkly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXD2tXAAKCRDj7w1vZxhR
xfD7AP4qywnKHNgiMVKQgQm9Unl856D2G5YayGFo46hzFw/4MQEA23fYuGlEoHwa
xCIReP3XHYr04DGgK/uAsJW/1WkT9Qg=
=kEiC
-----END PGP SIGNATURE-----

--mochvrg5c7cnhkly--
