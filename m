Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935632AbeE2Pe7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:34:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42264 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934940AbeE2Pe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:34:57 -0400
X-Auth-Info: wSdb0h7NLhWJ8Rn57+Drajt+Vtoiwo+dofMEF3M+8/Q=
Date: Tue, 29 May 2018 17:33:38 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180529173338.5ec631ee@jawa>
In-Reply-To: <20180529152225.GB16038@ulmo>
References: <20180412143715.6828-1-lukma@denx.de>
        <20180509154338.2841-1-lukma@denx.de>
        <20180519130533.2494bceb@jawa>
        <20180528095519.799adadc@jawa>
        <20180529143047.GB22634@ulmo>
        <20180529170148.7a0363f2@jawa>
        <20180529152225.GB16038@ulmo>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mcgMiqadJ.1Wr7YVbr.YNHL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mcgMiqadJ.1Wr7YVbr.YNHL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

> On Tue, May 29, 2018 at 05:01:48PM +0200, Lukasz Majewski wrote:
> > Hi Thierry,
> >  =20
> > > On Mon, May 28, 2018 at 09:55:19AM +0200, Lukasz Majewski wrote: =20
> > > > Hi,
> > > >    =20
> > > > > Hi Thierry,
> > > > >    =20
> > > > > > This commit adds support for KOE's 5.7" display.
> > > > > >      =20
> > > > >=20
> > > > > Thierry, shall I perform some more work on this code, or is it
> > > > > eligible for applying to your tree?   =20
> > > >=20
> > > > Gentle ping. If Thierry is overworked - maybe there is a
> > > > co-maintainer so he/she could apply this patch?   =20
> > >=20
> > > Please use the proper prefix for the commit subject to increase
> > > the chances of this being noticed. =20
> >=20
> > Ok. Is there any list of prefixes in the kernel repository, so I
> > could look for them (like get_prefix.py - similar to get_maintainer
> > script)? =20
>=20
> I don't think there is. A good rule of thumb that I use is to go over
> the git log for the last couple of commits and see if there's a clear
> pattern. This doesn't work for every subsystem, but drm/panel is very
> consistent in this regard, on purpose.

I see.

Is the DRM/panel tree hosted on git.kernel.org?

The tree maintained by you there seems to be:
kernel/git/thierry.reding/linux-pwm.git

IIRC it is hosted elsewhere. Am I right?

>=20
> > I've used "display: panel" prefix, but I should have used
> > "drm/panel"=20
> > >=20
> > > This is also still missing a Reviewed-by or Acked-by from Rob. =20
> >=20
> > Rob has already reviewed this patch. I will send v2
> > with Rob's Reviewed-by tag. =20
>=20
> Okay, I'll apply that v2 then.

Thanks.

>=20
> Thanks,
> Thierry




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/mcgMiqadJ.1Wr7YVbr.YNHL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsNctIACgkQAR8vZIA0
zr3hmwf5AYnCAw/Icb4IooODTOLd/yBjADMxIxM+uv+B21H5/Xo7gy2M5P5/d7YW
0EeudzRu6GhhmaR7k8wvekZjQ0vFZJnFDLec7Ga4iklN3MmXhcAke5Ti/Yx+tQGX
7vbbjE1zGubSyEUzs9cA/i45GKXIgk1ldQs5lXIxbGe0eIlMALh8av1Faco24Zqn
Q4Oxa2Fg8zArfYjuzo0DpWaWPzGQHJNEh4/fJeIylr/dbOc6MvqSLKiVusqobtfs
TXQ0F0RrVOBMWtmm3hiJ3vlTInxjHlEJEhyxfbFIAHyLNC7s4JkSY41OyMGpi2t2
dYyxumhB3p1hr6zq4ZSCEBMymON9Cg==
=qNsb
-----END PGP SIGNATURE-----

--Sig_/mcgMiqadJ.1Wr7YVbr.YNHL--
