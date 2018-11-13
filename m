Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62E2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F62E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbeKNAF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:05:56 -0500
Received: from sauhun.de ([88.99.104.3]:48528 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeKNAFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:05:55 -0500
Received: from localhost (p54B336A6.dip0.t-ipconnect.de [84.179.54.166])
        by pokefinder.org (Postfix) with ESMTPSA id 6B06B3E179F;
        Tue, 13 Nov 2018 15:07:35 +0100 (CET)
Date:   Tue, 13 Nov 2018 15:07:35 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 00/25] at24: remove
Message-ID: <20181113140734.GA970@kunai>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bartosz,

Thanks for keeping at this!

> for the next release Sekhar would pick up 14-24, provide an immutable
> branch for me and I'd merge the final patch for at24 and send it upstream
> through Wolfram's i2c tree (maybe we could even delay the i2c PR in the
> merge window to avoid the immutable branch altogether).

But we want linux-next coverage. So, I think an immutable branch makes
sense.

   Wolfram


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvq2qIACgkQFA3kzBSg
KbakIA//XbX4c8LZfdL5KUsFzRtMrPXALyqSS///0ymL1KJyrAFAYW0HSF6v3gQS
jUbnocRxTANZqsNyX+rkuBAnf0erKVZC0Ond96dqjqbNlssGmXXbQU1hn5ALtQUM
uXiisSMlPpRTbedlu6KsYCzWOpftOEW77NbqWtva5nDNPTx1IY7DuaAfJ6Y8bCF5
2jrk2SEuFiCkTvnNH8uuuqUWm//L1lWrgfdyThH4qFh/8+hliKcoJN9KHR520M4n
oBVChe0aAnYHmhInVs1S2SkavRmRYTWiVmuh7fX0XhrRwjy/NWxwc9M7yUWqwE6M
0a8aL96eazWa/wh6oBkrY23Mn7CAIeLPZjWbToWSeRxzF/0xNtOPaXIv0LfWj7he
cnBebxPh8OX8xaeXhWLemQCWwhw7Hlt5eD1eejohkSCs+TfewRt9GJnPZZ84wcPk
25zAWm1jcbgJwbUE84Fbd7e2iOUK/ssSA7moXB0YiCdDWUPM9KXuOPRK+//jYZ1f
qqS/jRK6lAevr0Ycovhs7KDQLcJ19XaFLh42FQb8CkEucxqleH8x9ZzFirP56WHY
xLK6PMWAC9TyVhvuPxtXb2U/pzndjxl34Y8PnexIUUX+Q+9r0XRjyJu6KLEIDpQL
o/GlKKLy/jQpbYDR08JxuPfBXYBR16SsKlddL02rlkibWTuCEWI=
=//jv
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
