Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29EFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A6025EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A6025EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbeFYRJU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:09:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34835 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933140AbeFYRJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:09:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5C31E206D8; Mon, 25 Jun 2018 19:09:16 +0200 (CEST)
Received: from localhost (unknown [88.128.82.118])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6B837203D9;
        Mon, 25 Jun 2018 19:09:15 +0200 (CEST)
Date:   Mon, 25 Jun 2018 19:09:13 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from
 lid
Message-ID: <20180625170913.p335obgr3rfa4skt@flea>
References: <20180622160631.8578-1-icenowy@aosc.io>
 <20180622160631.8578-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ehcemc3meyriletb"
Content-Disposition: inline
In-Reply-To: <20180622160631.8578-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ehcemc3meyriletb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 23, 2018 at 12:06:31AM +0800, Icenowy Zheng wrote:
> Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
> present. In this case if the lid is closed, systemd-logind will enter
> s2idle mode by default; however there's no possible wakeup source
> defined, so the system will enter a forever idle.
>=20
> Add the lid itself as a wakeup source, thus the system can wakeup when
> the lid is opened.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied both, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ehcemc3meyriletb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsxIbgACgkQ0rTAlCFN
r3RIUQ/5Ab9ZEYIpgD0wDHYTvyJCVQzz8eA3BNkt+inbR5gWZECchgUvrGzbW9TM
Ost03xAjymqk94GP5ngee0LKsks2GYbxRCwrN6Uyy/mE7JmSDEtS/dNStHezjh7C
S5fkmqEmku3KiNv7p26CSjKgys9rQgV5YqyJ0fiE2EZG4HY2fybtBdMNGYES2a42
W6NG117TPP052w8G0v5t3LMrAF7+NwqpOuVOpWFQjLjoGGwFwOUuM2N8DJO3KNA9
Hca6VH/UvBBW7WZYVG4erWrBPhhPGC/GmLsT13TI8vq4rHM2vKF/sMf4dHsEDXK3
W9+Tc3U+DVTOUZ3vOMuXo6XRjRbfmyobrbLCZqjUSkLyoapCilIX4Ip9OjtDgSCT
Om4ULKerAIGhWh7lVtiTobZimuv4Q/FMevpfGgIHC+2hI0XYNYwqgU1L6OTXwQQl
za1mASsjRYCP+2Mu473TlZmmbga7r1wAX1JixXcPMeivnGfYJoPIfGuSoG9IuFNS
+UJRX+iqToCCRj+IKevcdZkEP6tQnYZLo8Tz+KjNH/EhRug30pTp4spGrJf/koFH
Uh+Yf3vL8U1270+MlKpy8WD/AbG7QXUl7RcaTH88bIuvXtQ8HT4RmMs9WPaMJjcP
kT1x0GbKTo71a/HjlOJdfWuNF41dZD4uSruuwjaML4NItxcj8sU=
=ApLz
-----END PGP SIGNATURE-----

--ehcemc3meyriletb--
