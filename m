Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeDJPwx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:52:53 -0400
Received: from sauhun.de ([88.99.104.3]:41348 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDJPww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:52:52 -0400
Date: Tue, 10 Apr 2018 17:52:50 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Message-ID: <20180410155250.rjrfd6v5unqlf25m@ninjato>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lraj3gih757u3rtu"
Content-Disposition: inline
In-Reply-To: <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lraj3gih757u3rtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

> Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
> Was that the intent?

Oops, nope! Sorry, I just forgot about the demux (I think you mean that
one) driver and will create a seperate entry for it.

>=20
> > +I2C SUBSYSTEM DRIVERS
> > +L:	linux-i2c@vger.kernel.org
> > +W:	https://i2c.wiki.kernel.org/
> > +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> > +S:	Odd Fixes
> > +F:	Documentation/devicetree/bindings/i2c/
> > +F:	drivers/i2c/*/
> > +
>=20
> And this includes all the other muxes, i.e. those that are "mine". Maybe
> not a problem, but what do I know?

Sorry again, I really didn't want to dump something on you or leave you
all alone with the muxes. I was just so focussed on the host drivers
that muxes simply slipped through my mind :( I can add myself to the
muxes section again, no problem. I'll let you decidei what you prefer,
both is fine for me. You are doing a great job there!

Kind regards,

   Wolfram


--lraj3gih757u3rtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrM3dIACgkQFA3kzBSg
KbYzaQ//Rt5T/dUUTVyjsMynxbwA5pLKufNg1+SJVWT8EwM1Ne3vDMU7l44ftO00
Fu+Bw2gsAivUdk8GZYKl4ajropl2JlLrVOBkqJgMUJhMObPKGcmc6ySQ2azvvpIX
ijixI2SnpYh6EIlPx/JXiYxS8PZiVLrH7fKYMplRbTP9B2YmUHdDyODNEcvZ7zem
HFcPtzdEKQjdrVebP+7GTlDE8wFWfW6RxNcSp1nkg9ha5cTBOLDTZ9HYF+/M5WHH
IqYAgTS+XZ5przbZSARZClsvvlSMSPdO5avF1eQqKMbwWos7PI/+8oGAjMpZsytC
lTTUDCCT2OOO46akU5qmkYFyEOvqk1DOJxod2/r4/jV+CGq5LFhodg0BVjR10tX/
Jm8f+KTf3VfexCn3RcmJ4l7quR7kTyNq4ZvWG0GOFsH/gbihQG0ukW+TCBJOU2Ly
T7KbRjIuNjcRTo4XJ2cQmVg9edUeZFUkm8wWVy5DPh4YCF8rKoJS6fF7PT1TekNY
INcKRNOH3o5gGAgK/F0bbwHTmvkM5EHmb+reOi8NfGhu970FjT+QLWJSGOmgxRCH
36+Flw4wmUfjNIkZDlqM03i7DKiH9GuLM5P6t5teWTJuP7L63HmT9w+R6q4BkQkM
mOCc7blATKnvfaRLPiaYugmFJfmq7zMy0BZQbfxlZ2a15gkpX1A=
=Pr6Y
-----END PGP SIGNATURE-----

--lraj3gih757u3rtu--
