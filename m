Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F556C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DB2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394101AbfBNKjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:39:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39191 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbfBNKjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:39:48 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 102A58034A; Thu, 14 Feb 2019 11:39:38 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:39:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 07/11] power: supply: max77650: add support for
 battery charger
Message-ID: <20190214103944.GC6132@amd>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-8-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +#define MAX77650_CHG_OFF			0x00
> +#define MAX77650_CHG_PREQ			0x01
> +
> +#define MAX77650_CHGIN_UNDERVOLTAGE_LOCKOUT	0x00
> +#define MAX77650_CHGIN_OVERVOLTAGE_LOCKOUT	0x01
> +#define MAX77650_CHGIN_OKAY			0x11

Thanks for doing this.

> +#define MAX77650_CHG_ON_CURR			0x02
> +#define MAX77650_CHG_ON_CURR_JEITA		0x03
> +#define MAX77650_CHG_ON_VOLT			0x04
> +#define MAX77650_CHG_ON_VOLT_JEITA		0x05
> +#define MAX77650_CHG_ON_TOPOFF			0x06
> +#define MAX77650_CHG_ON_TOPOFF_JEITA		0x07
> +#define MAX77650_CHG_DONE			0x08
> +#define MAX77650_CHG_DONE_JEITA			0x09
> +#define MAX77650_CHG_SUSP_PREQ_TIM_FAULT	0x0a
> +#define MAX77650_CHG_SUSP_FAST_CHG_TIM_FAULT	0x0b
> +#define MAX77650_CHG_SUSP_BATT_TEMP_FAULT	0x0c
> +
> +#define MAX77650_CHARGER_CHGIN_DTLS_MASK	GENMASK(3, 2)
> +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)

But I guess these could use similar treatment?
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlRXAACgkQMOfwapXb+vKeNACeKRfN7OVB4oFp8dOR9nRaQtxt
RXEAni5CG3ToOk2cF9pUwPoHKM4lMFqB
=61KM
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
