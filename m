Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeBVNIm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:08:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:44279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932102AbeBVNIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:08:39 -0500
Date: Thu, 22 Feb 2018 14:08:31 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180222130831.hxhvdfyfpz4j4j5t@latitude>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
 <CACRpkdZKLm2owgVu7-f80dOdQDzQKCbO2Vvh3QHfOpEzndMxxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2silb4ycf5a2su42"
Content-Disposition: inline
In-Reply-To: <CACRpkdZKLm2owgVu7-f80dOdQDzQKCbO2Vvh3QHfOpEzndMxxg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:AwKwGlkOP6QVSMZ3W+0d7WLAeEYJhhpmgNLR4eKa0aLjReCxE9h
 CjzkXPgRb0Yp9cq2Z4kFMbnL/ZOCA074nP4qke3+h6Bs+jkwx8SyMyKWfDBoU55q6X6zPHw
 g2f8yEDgo59gb3s6Cs6wIOl38OwOXYqayGOC3oslWCHygUaLWaGrsnFW/4cBlhHXxR1U0Ej
 Ta+xoLxA6XLdfDruqdvHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YZV95bErMYU=:3ybBqNLqPTYzBtbAHKU4c2
 beEk0pQSiLPSmqwCz6C8dbf6Ty6noyHJ+8TQbbLdtsdX4YoTV1pOL0kO1RHvtEWA51KRYlDtK
 En2idG1vIPLQ8f1sNjmqCIM6BkrC1O7RIUBIvvg5yefh0NRcAAHcZHnxdvI2/Y29LC4gpK25z
 fZk0zpVpPE2ruW2CqhBKemBQO+sLg5vjI4M29E9qvXHw3wvnpD5y7c+h+DmgoieNR1F/otI4f
 weBdGbx6rrQ+LBvAUJgD53s06sOtEm6XRHKA1MMBW16Woc0PFO9Bx2YlWLREoLJ5u9XvMGX5y
 nOINgzkh/u+RmI6XVoSnD5whUDCM8VLHyWuuISqFYtEOOTJprodEADPfl71xG+m91D1gRlt3j
 mgYptYztHo8kbvygjEQBLypK40vs40B1ys8ngWTnYAPhQ1OGewa9Z3yFqFeI48/hZ9BOyTY+F
 KJf4LDKk5YYMzfNqCw6UGI1QHzB2YYyW5e3/z72aCmdZgXfne8i4QduWa18mPDtwZqYIM5SwP
 E707e8hv/Qzr2REwm9ozhD4X6D3/ZKisV0KgwosFhXxFnYnHlNLE+FxkFzh+1S5AtUfR1mVFA
 GZzla9ePWyYXpfZh/K4mqpoFYD4W7pFe5Hi0pmWzwJPOvy2FPQ4y7ZI97mnJn6BbDFgvjX8FO
 6BlyfBAsKNCPHobwlZErtIu38XuyzdkTxyt4hQHXBGyfFAez2rr+dFv0Zl8KeAIf1eOc07ArK
 doatMz5SdyC0dwOhcg93xGEyu6g0hWQMtU84N0LCShQ0UPq7sAOYGU5tAX54dFx0r0AnQ2gfV
 CX1sfAOsbSmaZMCaEAUqGZ7ICrcJw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2silb4ycf5a2su42
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 01:57:07PM +0100, Linus Walleij wrote:
> On Fri, Feb 9, 2018 at 1:07 PM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> > The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> > that supports a configurable number of pins (up to 32), interrupts, and
> > some special mechanisms to share the controller between the system's
> > security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> > not supported.
> >
> > This patch adds a basic driver for this GPIO controller. Interrupt
> > support will come in a later patch.
> >
> > This patch is based on code developed by Albert Herranz and the GameCube
> > Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> > available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> > has grown quite dissimilar.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: Albert Herranz <albert_herranz@yahoo.es>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > <---
> >
> > v3:
> > - Do some style cleanups, as suggest by Andy Shevchenko
>=20
> Patch applied to the GPIO tree for v4.17 with all the review tags.
>=20
> I just folded the changelog into the commit message, for new
> drivers it is sometimes useful to keep these around in
> git actually.
>=20
> If any further changes are needed we can just patch on top
> of this.
>=20
> It's a very pretty driver, good work!

Thanks! :-)


Jonathan Neusch=C3=A4fer

--2silb4ycf5a2su42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajsDGAAoJEAgwRJqO81/bEuEQAKyDSerRX42NnNKQtZyCS+1I
qYrcXBOLLdKa2ZOpNI9BxxalgJEJeJrRRpylu/sxbRsn+Kxbg1J5GVXf85c41wzs
YHQqe9PXXBYFnJKO3119HXt4OE3sfjfEU7AZ/trKzy3VklKuDif+lvicexBZaPFP
E/HIYWcMk7iCs817KOwau+SwXQwQe2wNOmCboG4dqTXvwWKGKEofOc3TlSYDmglc
1ccOrr5/QEpEWj917tFO5jkGJt8kouHzzyEKw/tUD+IPd3xA0hbIi1dz3+qWIcXJ
6AtQo6yDFYfLXhKev5QbR4Sq0EXzXrnlf0DebR4jksHgM1rnZu2Tog5udKmU8r0U
DPjvwsm539LYYTKGgV1cAkawOwLFT8QpyFgD5k1zUszMbayLjffWKG9iGrJAwWYs
ivB7DZwEPuem14FkJeUufrsGIG4mxq0MoXwP2JeH/GqWZi8mvH8xdIM93lhpms62
x+dU8qipsKOoao3j3F2GA07WwF4220JIFxtOJIuHVVlw5Cq4rOak94GRj4MeJEO3
USQ3bSoL549ZUrTTWPmzDSzigd/yVPt4vF9AMbYuVyWp1KXONEAEZOJiuncQt8vq
TzYKW8xPSD+fz+a45kW4UBWgmPx8u9udIXYUP8xCEO7mfsGLr0ZJSxfOqqkA7J12
E4SJS0ORWpGggYhec6zA
=xJG3
-----END PGP SIGNATURE-----

--2silb4ycf5a2su42--
