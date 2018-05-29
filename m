Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935181AbeE2PWc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:22:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34316 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbeE2PW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:22:28 -0400
X-Google-Smtp-Source: ADUXVKIpNjid3x1ogQTT+D4IY9cyU0a3RSGIdPmsyBvTgApWhTEaA3MSVHTHJLdVSUa8EURVzxtM5A==
Date: Tue, 29 May 2018 17:22:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180529152225.GB16038@ulmo>
References: <20180412143715.6828-1-lukma@denx.de>
 <20180509154338.2841-1-lukma@denx.de>
 <20180519130533.2494bceb@jawa>
 <20180528095519.799adadc@jawa>
 <20180529143047.GB22634@ulmo>
 <20180529170148.7a0363f2@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20180529170148.7a0363f2@jawa>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 05:01:48PM +0200, Lukasz Majewski wrote:
> Hi Thierry,
>=20
> > On Mon, May 28, 2018 at 09:55:19AM +0200, Lukasz Majewski wrote:
> > > Hi,
> > >  =20
> > > > Hi Thierry,
> > > >  =20
> > > > > This commit adds support for KOE's 5.7" display.
> > > > >    =20
> > > >=20
> > > > Thierry, shall I perform some more work on this code, or is it
> > > > eligible for applying to your tree? =20
> > >=20
> > > Gentle ping. If Thierry is overworked - maybe there is a
> > > co-maintainer so he/she could apply this patch? =20
> >=20
> > Please use the proper prefix for the commit subject to increase the
> > chances of this being noticed.
>=20
> Ok. Is there any list of prefixes in the kernel repository, so I could
> look for them (like get_prefix.py - similar to get_maintainer script)?

I don't think there is. A good rule of thumb that I use is to go over
the git log for the last couple of commits and see if there's a clear
pattern. This doesn't work for every subsystem, but drm/panel is very
consistent in this regard, on purpose.

> I've used "display: panel" prefix, but I should have used "drm/panel"
>=20
> >=20
> > This is also still missing a Reviewed-by or Acked-by from Rob.
>=20
> Rob has already reviewed this patch. I will send v2
> with Rob's Reviewed-by tag.

Okay, I'll apply that v2 then.

Thanks,
Thierry

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNcC4ACgkQ3SOs138+
s6GNJg//QNwLTu5zJwMdcqqDu33Oa89ye5Kn1PBUfKG1koPdAlzfrA+J1kpIqUlB
6c5sG0tDvyMLxM7LAj3gSIISTnWZ3SeUW1VItbfHuitLWJdN0k9BkMuGturoc6jG
tDs6BiKY5UONRR618Qpauo84aBt+HTnmzvlRWmOJwAPlQmRxQZccyGlE1yuKJnCN
AXA/2A4tWHJ6K+pQ6DsJRjtcj/q/QNv+5VBZ5OOlYuQU+fnuZUgObOtUEACAF47X
TLCpfBVMw8IWRxeM1GuOhvfWPEW20W6vmS68iY5MgtL8KAAXQKWc7zeFN6MmeN93
GUIRqUdmX/D5dakKNLZZGGi2HmDaq5NUv4JGhwqpXH2FkDlOzBRQexAAVx95B6Ft
8KRah9aDcAy1DppyTUZrKAErjd2hIeBGbbL2rsYjd3JYO6WotC8ohExOzurcz5uI
1dIV3kNmqa5mFGEh45j/mxPMypGRF3xP31HJ3RRBk54MVQSAL2av+kbU3p8ua/MH
hdVLeNrM+di6Q/0RKgbWMm7mTLkNu3wigS/OMcBm6kW7HvCbsgU7khuHRBVNywkG
BTVf5cc+kUoyP5k/U5AGB+VDU7OAj441EtIO7wgb/hf8NxDxFpBSEO28qmTv5XgA
3zRpuRO7gfp+IepgU2LgpLdsfBuxBIwadKQJ8tikYOZcNCUiUM4=
=bLev
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
