Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBHWcl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbeBHWcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:32:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4202721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 8 Feb 2018 23:32:36 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: power: reset: Document ocelot-reset
 binding
Message-ID: <20180208223236.47g2gzi4mb6blxgi@earth.universe>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-3-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpl5yojfuctp43sn"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-3-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wpl5yojfuctp43sn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 16, 2018 at 11:12:34AM +0100, Alexandre Belloni wrote:
> Add binding documentation for the Microsemi Ocelot reset block.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Thanks, queued. My public for-next branch is waiting for 4.16-rc1
tag, though.

-- Sebastian

>  .../devicetree/bindings/power/reset/ocelot-reset.txt       | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-=
reset.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.t=
xt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> new file mode 100644
> index 000000000000..1b4213eb3473
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -0,0 +1,14 @@
> +Microsemi Ocelot reset controller
> +
> +The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to re=
set the
> +SoC MIPS core.
> +
> +Required Properties:
> + - compatible: "mscc,ocelot-chip-reset"
> +
> +Example:
> +	reset@1070008 {
> +		compatible =3D "mscc,ocelot-chip-reset";
> +		reg =3D <0x1070008 0x4>;
> +	};
> +
> --=20
> 2.15.1
>=20

--wpl5yojfuctp43sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8z/4ACgkQ2O7X88g7
+pqtghAAgiEC59PSz82T7Q3MqiphoBzYiWxy1CoAtoheS2dFaM7E/EMJUSXJdD/z
JSGXtbkL4PsJ7Xxn5kcl3mg/fEQT/AjhnSA8K09CnfYrflySatb+aggMbSYjuvV2
+QlAyTPHwQl6WdhYbhurrl/OsR2tuU8D9iD1Jy9On8XbwGRrZ9Lmgq2bVko9RAYV
SIMnssSBeigwkcLGzFS7CJVOYByKrNjhY9daqUzIoG9SShqV6dz47owLVSgpGojn
e4DnkoIAD+GxLvMQx+vfTmmOzj25geJtyAGZOKQtd/JJJ0IpDK5BCQlL1nnR+nbD
opoKWErAaBr5gLxABnIrBfvfZak39tQ7dPPlK1iUMPCrdANjBdgTCyizZilim3/u
0lNd6GlA1Xz1AoQiUhjSyAT2Kqqx9b5DHgF9opcUZ1Tu7S/m12NkZSTcfpw1YCEI
vu/fLCVQD9qiplZZ6yrM6BlKKx1bnPOFBaQHOVWQkn2zZ3VM+6wHMzHKToH3c0lb
zJs00jQ96NrG/lJwz+iDUhzuhHV/7qaWEUFfRrLy1Js/gHOIC/uS7pZ5jvNSgPUx
9Winvj3lMCCQnujmNplG5DsHe3+rWRWgfHEETM5r89/ncN2bnIJ9eh2vTokaK5dh
d4UEv1ig4U7t27o+cOJy4FhUatzGLezI3or/pGmA4fst2HUzhDs=
=Ubpn
-----END PGP SIGNATURE-----

--wpl5yojfuctp43sn--
