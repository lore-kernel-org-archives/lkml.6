Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeECNKL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:10:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53070 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbeECNKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:10:10 -0400
Date: Thu, 3 May 2018 15:09:58 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 6/9] drm/panel: Add Netron DY E231732
Message-ID: <20180503130958.gh6mgbhon3uaha75@flea>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-7-maxime.ripard@free-electrons.com>
 <CAGb2v64RQdHZod7z4ErycNgGremj41-o4R_V_i7ThrCPLNhZOw@mail.gmail.com>
 <20160909143510.GB8881@lukather>
 <89cac24ddcb5f4ac710a697a4433c927e5c7e71e.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahmuzoycbtglsp5b"
Content-Disposition: inline
In-Reply-To: <89cac24ddcb5f4ac710a697a4433c927e5c7e71e.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahmuzoycbtglsp5b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2018 at 09:20:30AM +0200, Paul Kocialkowski wrote:
> Le vendredi 09 septembre 2016 =E0 16:35 +0200, Maxime Ripard a =E9crit :
> > On Wed, Sep 07, 2016 at 12:01:56AM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >=20
> > > On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > > > The E231732 is a 7" panel with a resolution of 800x480.
> > >=20
> > > From what I could make out of an archived version of Netron's
> > > website
> > > (it's unreachable from my place), they are a manufacturer of printed
> > > ribbon cables, not LCD panels. This is probably a no-go.
> >=20
> > I don't know. I haven't been able to find any website for Netron DY,
> > however, googling the part number I used find numerous matches on ebay
> > and alibaba.
>=20
> While starting a port for the A13-based TZX-Q8-713B7 tablet, it appears
> that my LCD cable also has the Netron-DY E231732 marking, but is
> definitely different from the one on the SinA33. So I think Chen-Yu's
> comment was founded and "Netron DY E231732" does not reflect the panel
> name.
>=20
> Here are some details regarding the LCD cable on both devices:
>=20
> The SinA33 has a 1024x600 panel with the following markings:
> 7300101463
> E231732
> NETRON-DY <> 1
> 94V-0\1310
>=20
> The TZX-Q8-713B7 has a 800x480 panel with the following markings:
> 7300101448
> E231732
> NETRON-DY <> 2
> 94V-0\1249
>=20
> So it seems that the distinctive part of the name is
> 7300101463/7300101448.
>=20
> Also, it seems that various online shops list the panels with a name
> like "E231732 7300101463". So maybe we could change the bindings to
> have:
>=20
> - netron-dy,e231732-7300101463
> - netron-dy,e231732-7300101448
>=20
> What do you think? Does that make sense?
>=20
> We should probably also fallback netron-dy,e231732 to the sina33's panel
> in order to avoid breaking the ABI.

That's kind of unfortunate, and maybe the netron part is just the
vendor of the flex cable.

In your case, I guess the best work around this would be to call it
TZX-Q8-713B7-panel, if it's shipped with a single resolution.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ahmuzoycbtglsp5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrrCiUACgkQ0rTAlCFN
r3Srhg//YBMcgkgz95TcbWcPSXdGXn1JBW7PO+rEbJUNKW7TsvzDp70GDOS/R29z
xUsHd7JHPD9pjJhQueFEIYi3gweJUdYBDqPQndn8KSDGKB7XruvOBpMxw/7WHf4R
m36jjpZBsDkQSlFLVs8SKQ4k2L+EpyFmr3f6cHRpR3mYFigXLhqiHqVTN8QzfrY7
fcu2ofzu/UWH7u6EvbRbNSfoVAn1H25OPvCqJA5/tSBVVJM9Xl5yHNeHjwNsnr+c
iMag4CVxyUyoH2/2BSTvex/kkEjU/whJcHiEPpl24GI2gt3BtlyqxKnbUKswQxV6
5ohr24/fWlhoDapTKq0kmvmZRvfC4b7F5cU0RAbmMdebNwpJiPndgxnHwaZ++umw
6E3VY5X1dJV2bGSMoXZam0wcf/CdgDlEMcfs7rJqbRN1jC6IuLMU3gIXI4kUULe7
kiiAZ+1SmmWE+hlIHe9ZRcDLIHbG+4YFsgyOefwSQyj7NynA0SK+UDr6kjHFIbrn
qBxQNTv9rvFKKao4+ay3+oTjiQR2JVNug3eF7HTa+mRg9wFW356pI/R8FAJLJiCg
4tBOoD4+CdXQk0aOmZlLCIDv0Dq+e7Q2dAKGL+r2ZMn7D0rol9Pkj9lcSdsHe1my
UAGRBG1klJy9p8krMDzA4dusg98pVCz1Jvg3Nvn6VkMGE5ULOnQ=
=HTNg
-----END PGP SIGNATURE-----

--ahmuzoycbtglsp5b--
