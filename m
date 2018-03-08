Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936177AbeCHSFW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:05:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39458 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeCHSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:05:18 -0500
Date: Thu, 8 Mar 2018 19:05:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: Re: Nokia N900: insecure W+X mapping at 0xd0050000
Message-ID: <20180308180516.GB16940@amd>
References: <20180308142818.GA9439@amd>
 <20180308162446.GK5799@atomide.com>
 <20180308164652.GL5799@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20180308164652.GL5799@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > * Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> > > Insecure W+X mappings, who cares about those? I have 7 pages...
> >=20
> > Is this with CONFIG_DEBUG_WX=3Dy?
> >=20
> > My guess is that it's for mapping the PM assembly to SRAM. This
> > is already fixed for am335x that is using drivers/misc/sram*.c.
> > I think omap2 - omap4 still need fixing if this is the culprit.
>=20
> Adding Dave to Cc, here's a quick fix for this one.

I did a quick testing and warning is gone. Thanks!

Tested-by: Pavel Machek <pavel@ucw.cz>

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhe1wACgkQMOfwapXb+vLVVACgl9X4HsNYjM7N9DJbpGmz2QqF
exQAnA1dB7AkLIdvcce/GHBOSsDZXIja
=JDWi
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
