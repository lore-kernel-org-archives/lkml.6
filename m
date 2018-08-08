Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A319C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDAD21A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDAD21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHHSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:09 -0400
Received: from sauhun.de ([88.99.104.3]:35564 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbeHHSQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:09 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id 699F66DB565;
        Wed,  8 Aug 2018 17:55:49 +0200 (CEST)
Date:   Wed, 8 Aug 2018 17:55:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
Message-ID: <20180808155548.s7p4xqsjywz3psrj@ninjato>
References: <20180808153150.23444-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lailtggovp2weizg"
Content-Disposition: inline
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lailtggovp2weizg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> This is a follow-up to the previously rejected series[1] which partially
> removed the at24_platform_data structure. After further development and
> taking reviews into account, this series finally removes that struct
> completely but not without touching many different parts of the code
> base.
>=20
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.

Wooha, nice work. I can't really comment on it but wondered how you want
to upstream it (after reviews)? Pull request of an immutable branch for
nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
it. Probably same situation for arm-soc...


--lailtggovp2weizg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrEoEACgkQFA3kzBSg
KbYbig/+IfP/OzJkJkFg3F1HAr1mBXaWGw4BAZ/b9fFp/VcIEJRZ5B1GZl9uXRts
TRoRnNM+JcJik9Lm4hdCNbsIB50QyqiChTwv+8C4zeMJ8RpN8KkhfHUpZ3C1rsV3
bNoCWk5ShWUUSPbiI6R+vEl3dTmfF2p+jybUVbu3dXD14z4fTKEA41yh2GsiKJ4I
9R1x6T4H9Vz0K1acONTk2ynfy3by8t+avkH5T2BdNtSQHHZ4tGOdRZ/uwV3LY8JK
/29JoqfvTjpzqldZaeu8L70VOLSNlgqEOHQAKa/1BcPT5jL4zGUvKtL0yxvrP7IL
YDP8NEs88p7gZmEL6WBPEZoDANygEu3Aka1ibvN0mj+9Vka7756tonRbYw7w1bMM
O4sqgFeZmx4UL3EfDnnyNe+9C74mY5CoK6XEOe9iRjxPY3HzkEKxDaCmogNLsqQC
9wGACEF7mJqcVykQ4eo+MZXdJ1svL0CUaPg+YmHBLRSzsmhfHh4aww/aFzvUFYNM
1mkZYgbAITrGO3qi7xChbSFcGiOxy3zrgM0IrKE448jM8qDj19hwP6O1Dcsu5B6X
lTq/DDSD+PrscM585jz1ORP3Us/Gr9t/5H+u4dNmshMcHGYyNhxft3KJh39HdqXB
l3L0WaE24LfQSwBt6sVnZQPSQn/9fpT6K8M/IMiepm2/SR7x/s0=
=hiI/
-----END PGP SIGNATURE-----

--lailtggovp2weizg--
