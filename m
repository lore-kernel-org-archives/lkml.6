Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F92BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174B2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIELpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:45:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:45:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BFBDC20766; Wed,  5 Sep 2018 09:16:32 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8EF9E206F6;
        Wed,  5 Sep 2018 09:16:32 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:16:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 01/11] clk: sunxi-ng: a64: Add minimal rate for video
 PLLs
Message-ID: <20180905071631.pke35tfyyeahdi3i@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7oe2u3mvnqtubzhr"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7oe2u3mvnqtubzhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:43PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>=20
> According to documentation and experience with other similar SoCs, video
> PLLs don't work stable if their output frequency is set below 192 MHz.
>=20
> Because of that, set minimal rate to both A64 video PLLs to 192 MHz.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7oe2u3mvnqtubzhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPgs4ACgkQ0rTAlCFN
r3SxHA//XLbWD0Kulk4uuzfKtKrYjg7kjUHZPbDeib6MPF/XDrwO2mKpSwCI5U4H
z+wUfF///iDG/aV+JanDFV4UlsrBFfljnSppVzyJHetT1Oq86aq+QR4i7/+egMfc
1zKiI7QQg0hrSGQy6KlqJojrvw0o6wg+0B4KxCroMMHzr1y1nZG1fLCB8hLPeSKu
VxMxbCi+AEdM9iSULHrHqcI5QWxevoF2qoNA8XvlPCTFJWTMR7zJMg2rty1z0WsQ
A6dpCaxmEpjbMJHZttrO8YsFVrGcB7Saa7D76eQKqj3HUpWZZaKL2KvwlX1+G3Dd
4hVskdU/frMvLDgtnoQEr2YBjrjDBp9uRQlpmKsQUliepulrABMzs2L4VJGKMrnp
tD+prx1CDhVgpWQCQ+KFFzdVg6zYQlX6OJ2Uu7tGdLmWegW9EwPWmcLMf5tziEZW
42ltBuPdO/mgZz3YfJdz3JBMlRFJlm95GeZIDzdPIva2aFTWxQ75yegMhDVC2ssH
y/Uk7dCKNmYYuHpjObmH7vtGTfQDsVC+NY7jDDHBuB5KdkXBqGKAEIEbQxDFi1KC
sJId98TSaXk1Vlo5f4HfX21oXMMFwfNmoZeWN+AdWy0UKKonrQNaQeFlBLqZ5jBI
ehQU/2iYFlt/HrnUh0VLcGFNDPwWoAx19ugVg/X+CzCKOLd3+jk=
=DeLG
-----END PGP SIGNATURE-----

--7oe2u3mvnqtubzhr--
