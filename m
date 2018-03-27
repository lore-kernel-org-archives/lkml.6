Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeC0HIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:08:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34994 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeC0HII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:08:08 -0400
Date: Tue, 27 Mar 2018 09:07:43 +0200
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
Message-ID: <20180327070743.u5slxdjnxqyt2zqt@flea>
References: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi>
 <CAGb2v64j5KHS5164V3naBwjJs0U3CE0nQBPBEvQBjSt=0s=nTQ@mail.gmail.com>
 <20180326144507.s5vit2cb7rjm6csk@flea>
 <CAGb2v66dmypdgrxGd44jR_4djaWR43UjaQcAJgx5g2Y0Yhhnwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fo5y5e2c2qwdhh7u"
Content-Disposition: inline
In-Reply-To: <CAGb2v66dmypdgrxGd44jR_4djaWR43UjaQcAJgx5g2Y0Yhhnwg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fo5y5e2c2qwdhh7u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 11:01:53PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 26, 2018 at 10:45 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Mon, Mar 26, 2018 at 10:22:45PM +0800, Chen-Yu Tsai wrote:
> >> On Mon, Mar 26, 2018 at 10:14 PM, Joonas Kylm=E4l=E4 <joonas.kylmala@i=
ki.fi> wrote:
> >> > Hi DRM subsystem developers,
> >> >
> >> > I ran into this patch where overlay plane was switched to cursor pla=
ne
> >> > because there was no proper cursor plane available on the display
> >> > hardware: <https://lkml.org/lkml/2018/3/17/120>. Can we discuss whet=
her
> >> > to have a policy of using a normal plane for cursor plane in case a
> >> > dedicated HW cursor plane is missing?
> >> >
> >> > Daniel Vetter suggests that it might be fine to use normal plane for
> >> > cursor plane because how to use the plane would be only "a hint to
> >> > userspace" (see the email linked).
> >> >
> >> > My motivation for having this discussion is that the newer Allwinner
> >> > SoCs don't have dedicated HW cursor plane and the sun4i DRM driver
> >> > currently uses the extra planes as overlay planes which makes moving=
 the
> >> > cursor on Xfce4 DE a terrible experience. To have better cursor movi=
ng
> >> > experience one overlay plane would need to be sacrificed.
> >>
> >> If you look at the development history, we've never supported cursor p=
lanes.
> >
> > X can use an overlay to put the cursor though.
> >
> >> At the beginning we supported one main plane and one overlay plane. Th=
at was
> >> it. The Display Engine 1.0 does have support for an extra hardware cur=
sor,
> >> but we haven't done the work to support it yet. I don't know about the
> >> Display Engine 2.0 though.
> >
> > An issue with supporting the hardware cursor we have is that as far as
> > I understood, the cursor plane in DRM has the assumption that it would
> > be an ARGB format. In the first display engine, the format is actually
> > an 8-bit palette with 1 bit of alpha iirc.
>=20
> Looks like it's 32x32 pixels with an 8-bit (max) palette, with full RGBA
> for the colors in the palette. I don't see the 1 bit alpha you mentioned.
> Looks like this needs some extra work for building the palette and copying
> the cursor image.

Indeed, you're right. I'm still not sure how it could be turned into
something useful though.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fo5y5e2c2qwdhh7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq57b4ACgkQ0rTAlCFN
r3S/NRAAiJQ6bUi9+ufW/9MLZs+pyH7omBbWwmmk9u3m+naj3vi/Qe785z8WMUmA
dxpcEZDigsmQVfyInble/GMnx7jFOf5unTELJg2pgUU7O/zQwUt7X3fGuIRRjeWR
fQyBeD6itP8bKh7I1VKolARaI68xXWgedV3VAMfbvwgCToyGIlwdbSf01iOo6+dL
qoKWsiQqnhSlNofJ1QGAj1wuctqGgAMn2csCK3PqUE04nhR7Dd+HM63+xP9P59+p
mWMBD3PogCWb249be1LIS0maA+DBl+EwnP6GA4V1S8JNtusrx+DRd6uRhzVJY/Wx
JVRSpfUXf5qdRUeFlj7zHGKNCu5XuzI+FuakuXi5XICkmiujjH8lyufAVo5dzU70
JbGWCNyBBXDww5uMc+9bvQXEPwOTReKNG979+7n3xl51JHmsS+SZM2q4gPO+wPqD
sUSVOPYX0TT0mSXitGW+DyKejnXHHdFZSZUnRpYRMMJ9PLzjYKVPjHP0vLS4yI+g
O5klMnIe+YIHK+dWaPlC9Vr5H+bjNvWJRA/XtrnWVZky0sglCYGS7gwXxuiT9I0A
Qn+G6dlb+iCuI0mc3jHzEyBDrwbeUVQjAJDg4+GD2fg+inVKWap5Cf4lTyIhnhmc
mq95m7tkzMDYeev0g9T7sgUSQZGYawSz4gy0dhgBWLuGcM1a/RY=
=Nwwz
-----END PGP SIGNATURE-----

--fo5y5e2c2qwdhh7u--
