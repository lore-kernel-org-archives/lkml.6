Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966928AbeCAJ1G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:27:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34502 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966856AbeCAJ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:27:00 -0500
Date: Thu, 1 Mar 2018 10:26:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Cc: hao5781286@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org,
        Claudiu.Beznea@microchip.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 1/4] dt-bindings: pwm: binding allwinner
 sun8i.
Message-ID: <20180301092646.44rxuwui2ssiar4u@flea>
References: <20180225135045.GA14508@arx-s1>
 <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtiwzdbgltohjq4r"
Content-Disposition: inline
In-Reply-To: <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtiwzdbgltohjq4r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 01:51:59AM +0000, Andr=E9 Przywara wrote:
> On 25/02/18 13:50, hao_zhang wrote:
> > This patch adds allwinner sun8i pwm binding documents.
> >=20
> > Signed-off-by: hao_zhang <hao5781286@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 +++++++++++++=
+++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > new file mode 100644
> > index 0000000..e8c48be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > @@ -0,0 +1,18 @@
> > +Allwinner sun8i R40/V40/T3 SoC PWM controller
> > +
> > +Required properties:
> > +  - compatible: should be one of:
> > +    - "allwinner,sun8i-r40-pwm"
> > +  - reg: physical base address and length of the controller's registers
> > +  - #pwm-cells: should be 3. See pwm.txt in this directory for a descr=
iption of
> > +    the cells format.
> > +  - clocks: From common clock binding, handle to the parent clock.
>=20
> The manual tells me that there are two possible clock sources (24 MHz
> OSC and APB1), with actually two bits for encoding the mux source,
> allowing for two more potential clock sources.
> So can we extend this description to provide up to four clocks, with a
> clock-names property telling the driver how this maps to the mux value?
> Either we use clock names matching the clocks mentioned in the manual:
> 	clocks =3D <&osc24M>, <&ccu CLK_APB1>;
> 	clock-names =3D "osc", "apb1";
> or we encode the mux values in the clock-names:
> 	clock-names =3D "mux-0", "mux-1";

I'd prefer the former.

> Don't know what's more widely used in those cases, the latter seems to
> be more future-proof.

Not really, nothing prevents the next generation to have three bits,
or even 32 bits to do the muxing :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dtiwzdbgltohjq4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXx1UACgkQ0rTAlCFN
r3SzDA/+PXFChqP0apbpYbna3qlRQMoRUMhWdpYY5FNXrE6+rp0zvrIFRaM1GkXp
RVAcYhGjFJkWUPz8ydKVsWf6CFfwCP1OAEFP63LpXWDZG7CDfFxTdXwdsdEnBlL5
f9VwZnZnWU+pq8xH1GSqrz55VQJmEOUJIsrknoMb/jP7IiFwTcn1zij3pUVDgj01
mtRn/23JVxcWA1gYuT8LmmY6mftmwG+Oo0T2jQwnaasxsknNnQpbNOflj00L49RE
e4tOA6pVXjYAlLCQEAVzp0uS7TTs6MJXCeuK7yzfE5yY2Pigo+1lPQIl/shGUz9r
ZmhtCt6QuGnpDEg4WDBrjUL7FtPMazsxAwocoY2TCRGi1dUzwqh8KoHl3HAPIt75
LpK9Qmm2LEpFvClIRzUIeFaFSkovSIWmPBePD3mQ1vw/6Euce9/R/t4MpRQHy5VQ
JVAbSPFhomjPRh8n0WQau6x/X2sOC59Ici/oehO1qxQBlHfdX2Nd1e3WnghrJzz/
wWA678qpqe5saLFrt5jS+fWJSLY9E38IVqgu3xpeFwnRGOfJMALOViCVFQUu7cjZ
VbGUApsK4siERQNziR3dw8I+OOPSoe/pyw8LWu1fv6/1C7cvR7aKPvgXtbHoRN9d
CvzZQ3+CqCl+bkHToTpf3L5/ZomQcChAm2w1rGtxR++dQx2wrqU=
=AruB
-----END PGP SIGNATURE-----

--dtiwzdbgltohjq4r--
