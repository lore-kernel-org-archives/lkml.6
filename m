Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeBQU2F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:28:05 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44862 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeBQU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:28:03 -0500
X-Google-Smtp-Source: AH8x227CLdxKSUiWMsTDRVENa9c7RKdu98lCK7crg2KwOelTHPG2YnCIhPjNMeFeb5BPRF2JE128qg==
Date: Sat, 17 Feb 2018 21:27:53 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org
Subject: Re: [v3,04/11] watchdog/hpwdt: white space changes
Message-ID: <20180217202753.GA13626@gmail.com>
References: <20180215234400.5022-5-jerry.hoemann@hpe.com>
 <20180217161734.GA671@roeck-us.net>
 <20180217193208.GA27788@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180217193208.GA27788@anatevka.americas.hpqcorp.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2018 at 12:32:08PM -0700, Jerry Hoemann wrote:
> On Sat, Feb 17, 2018 at 08:17:34AM -0800, Guenter Roeck wrote:
> > On Thu, Feb 15, 2018 at 04:43:53PM -0700, Jerry Hoemann wrote:
> > > Minor white space changes and some name clean up.
> > >=20
> > > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > > ---
> > >  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
> > > =20
> > > @@ -102,7 +100,7 @@ static int hpwdt_time_left(void)
> > >  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
> > >  }
> > > =20
> > > -#ifdef CONFIG_HPWDT_NMI_DECODING
> > > +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> > >  static int hpwdt_my_nmi(void)
> > >  {
> > >  	return ioread8(hpwdt_nmistat) & 0x6;
> > > @@ -133,7 +131,7 @@ static int hpwdt_pretimeout(unsigned int ulReason=
, struct pt_regs *regs)
> > > =20
> > >  	return NMI_HANDLED;
> > >  }
> > > -#endif /* CONFIG_HPWDT_NMI_DECODING */
> > > +#endif					/* } */
> >=20
> > I disagree with those changes. While I don't object to adding the '{'
> > per se, I find it very useful to have the 'CONFIG_HPWDT_NMI_DECODING'
> > with an endif to be able to associate it with the matching #ifdef.

Well, it does not follow our coding style.

Documentation/process/coding-style.rst:

	At the end of any non-trivial #if or #ifdef block (more than a few lines),
	place a comment after the #endif on the same line, noting the conditional
	expression used.  For instance:

	.. code-block:: c

		#ifdef CONFIG_SOMETHING
		...
		#endif /* CONFIG_SOMETHING */

>=20
> The matching /* { */ and /* } */ allow for quickly the finding of the
> matching ifdef/endif.
>=20
> In the "vim" editor, the command '%' will take one from one curly paren t=
o its
> matching curly paren...

'%' in vim let you jump between matching ifdef/endif as well.

>=20
> There is a similar sequence for emacs.
>=20
> >=20
> > Deferring to Wim.
> >=20
> > Guenter
> >=20
>=20
> --=20
>=20
> -------------------------------------------------------------------------=
----
> Jerry Hoemann                  Software Engineer   Hewlett Packard Enterp=
rise
> -------------------------------------------------------------------------=
----

Thanks,
Marcus Folkesson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqIkEUACgkQiIBOb1ld
UjI44g//f8iy67zXiC5L6WqNn8Fdesj55EERhYKRqu8XBodeCsSj47pnRBHAU6Nj
vPhsESmv12rv+Nq8ON7KFQfekRscaF4LAbF0H+P3RkNDFY9yfunk/3KSISXy190e
dMoC19sQ0CgZCA1z699ML0fwFjJob/jHGsKis+mhYObQj4NpWH3YGwDwcP5Qhhk7
hAeqHDWK2wuoGazNURd+lAecA82WHRFYlD51Wxfdndp/8iq6gsrYtODN4IxJsWAi
Pm+X2y1m8a6khLi4GcMdkd6K8+OZ3zGm+HL5E3jmCT8ypaM8KiO3qg1qgaP0Gqo/
XXkmfqxgm15ro4vKRciHX6rHdZnLKBxspKsncGBTyIlgUrFHT/MA0YRm4pBqTWpa
2vYxi4Um8abqTydg4w45B7xVipIr8kP/t3Vkb+V7NrcItlIOgxyUXokYNz8BfrHN
WMDdKg3yuNycKHXGHVyJ3sHXVkaiXqhDmjjUIiu+n+YKTo98SVGK9kpxkGa9bwNs
9iM6Vs1EDAYYeYqSSWiTxxcK5jZcmm9WXGplTav4LzGn1SgbDO/j0WbGCYAkKoY4
Yj2kflsDnL0+amTX97ZnQYBXkvRl+be7JY6zkwSt+D2ckgJJ9ehx1Jc6jXQOiq+N
mJzdpBNsTDxugDwBNPaSWfC+pfDGlg2C3zYjpQP3lyDR13Lf0PI=
=oJjU
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
