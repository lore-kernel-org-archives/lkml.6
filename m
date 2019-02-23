Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB216C10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE95020850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfBWJcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:32:10 -0500
Received: from sauhun.de ([88.99.104.3]:53562 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBWJcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:32:10 -0500
Received: from localhost (p57BC9845.dip0.t-ipconnect.de [87.188.152.69])
        by pokefinder.org (Postfix) with ESMTPSA id BC7312C3312;
        Sat, 23 Feb 2019 10:32:07 +0100 (CET)
Date:   Sat, 23 Feb 2019 10:32:07 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v4 0/2] i2c: designware: Add support for a bus clock
Message-ID: <20190223093207.GC1018@kunai>
References: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 04:10:57PM +0000, Gareth Williams wrote:
> The Synopsys I2C Controller has a peripheral clock that some SoCs=20
> require to access the registers. This series also details the new clock
> property in the bindings documentation.

Your SoB is missing for patch 1. And besides my ack, I'd still like some
feedback from the actual driver maintainers.


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxExcACgkQFA3kzBSg
Kbbf4g//TujUaeMwqhkaKlx4ZBmDq4MuNjaJkLFxuwd6+UM/aLM4g81XAUhNIF8f
Rj0fDiMgsxOGmxlq668hN8vayZen0fcCYM2yAhjfMstIhALWF10x8ckupGd82YMm
BAJ1eigAf02PO9Af/JDPlAdGHmoCQ6bkbawB7QFlfTqkaBrPJPOjdL2V0kO+Orh8
jhuuZLr2X2IdmYzx+egDvL7AWDypuruwonJTFpw5reosqKPmRzH6IZJ4w+iFo2G6
8bjSvpoyyci83TTaLFuhMcxvVH/42Izq7vHq9uRIgJakcr7TSitOPhx3Pl+Y8PLL
/rJYSt1jwozxMA1dIbB3thjF/hW8qe7KgZByKd46ax3P5iikKoYlkWal5CW+OIEI
D1TKycw9tXGlcVGKHJK+kVmOOOihp7gD5cNmg4bqULiYe+sEAzVhVTY+xzkL3eM5
vBtRRB5TdZeDNJ0kDZbXLlJgPJSnTgYZpbMsRPy40w7WLj5mw7/Zg6xBul3sYiu8
cYdq8jHGhavXhgOWeJN23hYdF3ly/SLSMfoswbRWBZ3zzCSjrKu1+8tRfVvGS+Gh
HzTuDa09MgX50JwsNw+XSzPugZWDFrEG1l9rS7yuR6e31b6bHxVKZjsky8i8u68F
AJZYZS7V5lIUgE8WXl6T/DXU5DGM/1Wzxd/zzOnCt5wnfGhosHc=
=H1Po
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
