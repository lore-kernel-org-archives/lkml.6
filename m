Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeEaJjQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:39:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44322 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754166AbeEaJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:39:14 -0400
Date: Thu, 31 May 2018 11:39:02 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi
 support
Message-ID: <20180531093902.j5cavatvsbb3iqis@flea.home>
References: <20180529172238.9718-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rysyajvfc6dat3b2"
Content-Disposition: inline
In-Reply-To: <20180529172238.9718-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rysyajvfc6dat3b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 29, 2018 at 10:52:38PM +0530, Jagan Teki wrote:
> +&rtc {
> +	clock-output-names =3D "rtc-osc32k", "rtc-osc32k-out";
> +	clocks =3D <&osc32k>;
> +	#clock-cells =3D <1>;
> +};

It should be in the DTSI

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rysyajvfc6dat3b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsPwrUACgkQ0rTAlCFN
r3QDpA/9EReRjGSopljLWBK4uLmP1r9wm6lBX2cnLko4C+R1TuVAlBF++qPPaffE
O+/rEWFYUSzvCPl4J2aI5Jxvlv+XZ9tq3tPdDpsRoBu3kvDiIO1vnOUb4ls1XRWT
4SI/uWKQmctl8XGB1JowpPNQgtwwW/TdgHc8+Cwu5Em0dWpD9PCaNVAsCz4fmrUb
SDJhGGqmjNbzONawQS8mrYHr9jz1HUQwaUQreHAvzcokbqMLu9hsLRTuMiB4RnGh
74sx/ZzJVZH4j35VAfRTMNhQYcX8cWn9BsVELJDMYsX6zm0fT0rSuUP2KxdsQsB9
fqmolQLn8kt61nL2Tv/hgevOkSM0cDJMsXFA9osmse5vyTzvkrioPiI4Qjjs4Tpt
16w8ivchYD57Od83bKVuMcF+2J0C1JCcGiukHMIYz5QoRBuIJfunvHft2aNTbnpC
cx4y0yTH5laxIuCdg/28w8hkp2zkDxskfLvaG9AG6iqGSqMb5yIBXzTa33YfF4Dz
SyrzM9rMGS0dsAjZ/oZJKSFg2JIoE0uflBs8QXtSZeZ89dVyF2QoPiJNOXhctgTg
Ac8wdwHAAXIbfdKiDEYPN+Z0MDijanDMZ9pvpKi/Wx1seZNeyKT6ZNdFpoyNL5VS
FJ8xCyZWBeVpnVk8AgfStdZddB7ekrrAsYcm8ebcqZEK8NxMomI=
=HxV1
-----END PGP SIGNATURE-----

--rysyajvfc6dat3b2--
