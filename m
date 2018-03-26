Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCZOpU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:45:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47090 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeCZOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:45:19 -0400
Date: Mon, 26 Mar 2018 16:45:07 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Joonas =?utf-8?B?S3lsbcOkbMOk?= <joonas.kylmala@iki.fi>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Preferring cursor plane over overlay plane
Message-ID: <20180326144507.s5vit2cb7rjm6csk@flea>
References: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi>
 <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="blpnstsklbc25qwo"
Content-Disposition: inline
In-Reply-To: <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--blpnstsklbc25qwo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 10:22:45PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 26, 2018 at 10:14 PM, Joonas Kylm=E4l=E4 <joonas.kylmala@iki.=
fi> wrote:
> > Hi DRM subsystem developers,
> >
> > I ran into this patch where overlay plane was switched to cursor plane
> > because there was no proper cursor plane available on the display
> > hardware: <https://lkml.org/lkml/2018/3/17/120>. Can we discuss whether
> > to have a policy of using a normal plane for cursor plane in case a
> > dedicated HW cursor plane is missing?
> >
> > Daniel Vetter suggests that it might be fine to use normal plane for
> > cursor plane because how to use the plane would be only "a hint to
> > userspace" (see the email linked).
> >
> > My motivation for having this discussion is that the newer Allwinner
> > SoCs don't have dedicated HW cursor plane and the sun4i DRM driver
> > currently uses the extra planes as overlay planes which makes moving the
> > cursor on Xfce4 DE a terrible experience. To have better cursor moving
> > experience one overlay plane would need to be sacrificed.
>=20
> If you look at the development history, we've never supported cursor plan=
es.

X can use an overlay to put the cursor though.

> At the beginning we supported one main plane and one overlay plane. That =
was
> it. The Display Engine 1.0 does have support for an extra hardware cursor,
> but we haven't done the work to support it yet. I don't know about the
> Display Engine 2.0 though.

An issue with supporting the hardware cursor we have is that as far as
I understood, the cursor plane in DRM has the assumption that it would
be an ARGB format. In the first display engine, the format is actually
an 8-bit palette with 1 bit of alpha iirc.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--blpnstsklbc25qwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq5B3IACgkQ0rTAlCFN
r3SBMA/8DHgdIjUlBzmbc9g0r2iz6DHa6f8cpu46f5jI91r39Nthop6udgpHBq3n
INTL4I5SUSw1e9MqPKrDSNE68s8NKgcPW+wn88lJyfz4coQ1jan18/WwCmVu25Rf
eFnE3LHOdDvGEjBjVK46N4uZ91zCmFPwE0+wsFrwUWyWrkxMCk3wQYlzTu6Gy3vU
wrGL54OpSf9v+sMw68Jk/BBKFCPhtkAdx2qIOPq6tw8Nv7K/MySbnSRJZ3NOLB6d
THb2c/QvY/Y1X3ChA7mN0cr2Mze229EiIPcaJoOTWRd6HDES07WRobR6gP6y8a+Y
Znk8NKJGTYETphvSd5ubgqGr+zRhzws/t/Ocx6YeLoFFhNkvMflv0eNKDh+94aOK
ub6fMfIaJRrDdTWXvaNWQT+n16zYDBtlYuakuVWasQfOr+5fiiU4coDQZ/1NjqGP
vWi+uHNWdGVQby5gCSY+2NcXeidiT3Yv8EXul9cj7BZ6f2sSCqxa2q8t64Q6eCp0
ec28tOXrI0vs3NeqeYh5vtuvE6IHk0lAB3+Ydo0jYF81DBl/MBEd+riJ4GSPXDgm
+xGunS2Y7Mi+6aSjWTz1GpvWdrFte0YtubmDGGKVnlne8hF0QVp86SxSNrZa25bc
vpLA+MTJ7ZnpLdtp6TgvxtD598VqLxsHA9jyKwJcTfms+Q5XAUQ=
=za9L
-----END PGP SIGNATURE-----

--blpnstsklbc25qwo--
