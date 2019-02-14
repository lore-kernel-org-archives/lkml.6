Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04FD2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393165AbfBNKh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:37:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39138 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfBNKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:37:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 587AF80344; Thu, 14 Feb 2019 11:37:18 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:37:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190214103723.GB6132@amd>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-3-brgl@bgdev.pl>
 <20190213204834.GA31342@bogus>
 <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +Optional properties:
> > > +--------------------
> > > +- min-input-voltage: Minimum CHGIN regulation voltage (in microvolts=
). Must be
> > > +                     one of: 4000000, 4100000, 4200000, 4300000, 440=
0000,
> > > +                     4500000, 4600000, 4700000.
> > > +- current-limit:     CHGIN input current limit (in microamps). Must =
be one of:
> > > +                     95000, 190000, 285000, 380000, 475000.
> >
> > Unit suffix? Really, these should be common properties. We have
> > some I think. Charger bindings are a mess though...
> >
>=20
> Do you mean a suffix like: ua for microamps and uv for microvolts? I'm
> not seeing any other such properties.

Documentation/devicetree$ grep -ri microvolt .

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlROMACgkQMOfwapXb+vLNdQCaAo+4r83xaUgQipX/MRUY+nFR
MjYAoJkeKxbdk5V1BQmqhzzCvblyyxwc
=S9/A
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
