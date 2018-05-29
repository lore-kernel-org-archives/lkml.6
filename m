Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964978AbeE2QMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:12:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53202 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935383AbeE2QM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:12:29 -0400
X-Google-Smtp-Source: ADUXVKLwcr7gR/FMGrUs/ioKRtpi4FGR+O7hJnYhBMq/YKGNEelgqQftfwBapiEHl1YP9T+UWogKow==
Date: Tue, 29 May 2018 18:12:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180529161225.GC16038@ulmo>
References: <20180412143715.6828-1-lukma@denx.de>
 <20180509154338.2841-1-lukma@denx.de>
 <20180519130533.2494bceb@jawa>
 <20180528095519.799adadc@jawa>
 <20180529143047.GB22634@ulmo>
 <20180529170148.7a0363f2@jawa>
 <20180529152225.GB16038@ulmo>
 <20180529173338.5ec631ee@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20180529173338.5ec631ee@jawa>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 05:33:38PM +0200, Lukasz Majewski wrote:
> Hi Thierry,
>=20
> > On Tue, May 29, 2018 at 05:01:48PM +0200, Lukasz Majewski wrote:
> > > Hi Thierry,
> > >  =20
> > > > On Mon, May 28, 2018 at 09:55:19AM +0200, Lukasz Majewski wrote: =
=20
> > > > > Hi,
> > > > >    =20
> > > > > > Hi Thierry,
> > > > > >    =20
> > > > > > > This commit adds support for KOE's 5.7" display.
> > > > > > >      =20
> > > > > >=20
> > > > > > Thierry, shall I perform some more work on this code, or is it
> > > > > > eligible for applying to your tree?   =20
> > > > >=20
> > > > > Gentle ping. If Thierry is overworked - maybe there is a
> > > > > co-maintainer so he/she could apply this patch?   =20
> > > >=20
> > > > Please use the proper prefix for the commit subject to increase
> > > > the chances of this being noticed. =20
> > >=20
> > > Ok. Is there any list of prefixes in the kernel repository, so I
> > > could look for them (like get_prefix.py - similar to get_maintainer
> > > script)? =20
> >=20
> > I don't think there is. A good rule of thumb that I use is to go over
> > the git log for the last couple of commits and see if there's a clear
> > pattern. This doesn't work for every subsystem, but drm/panel is very
> > consistent in this regard, on purpose.
>=20
> I see.
>=20
> Is the DRM/panel tree hosted on git.kernel.org?
>=20
> The tree maintained by you there seems to be:
> kernel/git/thierry.reding/linux-pwm.git
>=20
> IIRC it is hosted elsewhere. Am I right?

drm/panel is part of drm-misc:

	https://cgit.freedesktop.org/drm/drm-misc/

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNe+cACgkQ3SOs138+
s6EctBAAqzveHD1lZJIkZfJP1zsaPE4dL/xIOO39C8+12nbVLut6IqCYjjDr34uD
2hZXhpv6bQlpsWd6JMaG2IZ8fiIFQPpC2oWKgxRbj4ivXaTsCGDJ+yW3grZ0q8ZV
NUX7YEWeJ00sloIivbbCbXtk6PRBEqrrBXvT5rQpkvMogloLxQMS4N/eBJVO7QcY
geyiYIZTWfD2jxbZvb8MEFhjoB4Wk6+/8A7WBFEsZYUPcGrhZ+UUkX1Rqvx+3ZUV
FTINUTjnkBU8v6zHnDkUZYwObGahSJT187fZN1GxWiiUfVvWfCjo4ye0kl2R6Rdj
aMMKVG152jclKJdGIOdX2cT0mbCSl/i0nSEBhTbhMxBQqOKhnuhQt2S1SDIf320o
AyKEFD8IZWezlr6fEIEbR52UfDqHJS4L5DDCmBwJ8jUxOaOFwvj40eDwq9hDz+bi
qH1eaME/TRQ/HbXDnxOop8UDr3fC9DImtfWa8Po/1db6TVT5ASZikVqBi4WIo2cp
GxbFKeXJatfyK7ALQapRVUYBpetBvzp7D91cHVH2aP/J4dtpkTQ9Hcqb7gvTNQBm
HUHDziGc3p9phC6toXTW5GjkYgxAndBN9d9xDvcSBcFREulqCz4UlHyGvkpT6KcC
8CnyRqSeGe4Zaf09t2zWiv79jPDG7xvRoP2f7ZjnT3ZKNjUWKfo=
=NtW1
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
