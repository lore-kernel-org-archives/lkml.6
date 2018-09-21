Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9526EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E20321565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E20321565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbeIUU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:26:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42044 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeIUU03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:26:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A5902208EB; Fri, 21 Sep 2018 16:37:17 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7242B208B1;
        Fri, 21 Sep 2018 16:37:07 +0200 (CEST)
Date:   Fri, 21 Sep 2018 16:37:08 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao.Pinto@synopsys.com, festevam@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: Re: [V2, 0/5]  platform: dwc: Add of DesignWare MIPI CSI-2 Host
Message-ID: <20180921143708.tw62sci3il5ydmlq@flea>
References: <20180920111648.27000-1-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7nx7oggbvkdgp5n"
Content-Disposition: inline
In-Reply-To: <20180920111648.27000-1-lolivei@synopsys.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7nx7oggbvkdgp5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Thu, Sep 20, 2018 at 01:16:38PM +0200, Luis Oliveira wrote:
> This adds support for Synopsys MIPI CSI-2 Host and MIPI D-PHY.
> The patch series include support for initialization/configuration of the
> DW MIPI CSI-2 controller and DW MIPI D-PHY and both include a reference
> platform driver.
>=20
> This will enable future SoCs to use this standard approach and possibly
> create a more clean environment.
>=20
> This series also documents the dt-bindings needed for the platform driver=
s.
>=20
> This was applied in: https://git.linuxtv.org/media_tree.git

I'm currently working on some MIPI D-PHY support through the generic
phy framework that could benefit your patches.

https://lwn.net/Articles/764173/

Feel free to comment on that serie if you have any particular
constraints or if you believe that some issues should be addressed.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c7nx7oggbvkdgp5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlulAhMACgkQ0rTAlCFN
r3QmUQ//XF60LOknBdPj2pSVG9lN/euY3ycx2+GtMHzZmBdoECVoEhdxdxfIvZ+I
r64m6paIimQyo8Z2ArHZemGgU8z1VtzQTHuB5ySEkIHNN7de7cdJxsu86OR8JU0+
pcAqSwRYPSP8OcCVPC5uFmlHOnK2sxwRzHYh5UHH/t3LZTcKb2jaGTdzfx+gGPml
JudjPsm01E+evT0Z26B3b54Lx4EUPlkn+J1RRmkDzwkqjs3RWDQV3uBiXnljI+WJ
I0s2UAz4VLIs4tNcewW1oGwam8EWoCuY1eFO8qLiu3QHOF52Snd7fII7YjinOXUC
Iy319+groqiqTZXs7y9XIXWT1bhkXSTM1eZAx0+t4SO+Bl/BKxW6VAxrovqc9yTj
1eHscjqqcYRJvH/T0Rju/molqN5cpSG56nYH7GkBJNM6Dcn48Q+syotgz3hSD68f
UlwtUf0vt31jVMykNKbNCLxMDn3z1ahctoB/AbUTwH7fpALHiX0pL3eh2LiTP/zy
XnmHfg5qzeReieNOKdbMTtBjCNaK61sYeReea5qH9S0MmqwfgZaHNw7nF4sjUV4v
SZK/rvGIZF9OioPiVygeUEk409stuwFVGaUrzOUIMSlhg5rzXf1uUPX714Ozkr3U
bK2kwokgLte6uJAuyBRkmw7W0vYELWbmKnhhU+aubo8buMjGtEI=
=qdj0
-----END PGP SIGNATURE-----

--c7nx7oggbvkdgp5n--
