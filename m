Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeCUWzz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbeCUWzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:55:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C1A2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 21 Mar 2018 22:55:48 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] MIPS: add support for Microsemi MIPS SoCs
Message-ID: <20180321225547.GB13126@saruman>
References: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 02:07:55PM +0100, Alexandre Belloni wrote:
> Hi,
>=20
> This patch series adds initial support for the Microsemi MIPS SoCs. It
> is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).
>=20
> Changes in v6:
>  - Fixup SPDX identifiers
>  - remove unit-address for cpuintc
>  - add unit-address for ahb
>  - remove CONFIG_32BIT requirement (implied by CONFIG_CPU_MIPS32_R2)
>  - Add TLB entry lookup provided by James
>  - Readd vendor prefix addition
>=20
>=20
> Alexandre Belloni (6):
>   dt-bindings: Add vendor prefix for Microsemi Corporation
>   dt-bindings: mips: Add bindings for Microsemi SoCs
>   MIPS: mscc: add ocelot dtsi
>   MIPS: mscc: add ocelot PCB123 device tree
>   MIPS: generic: Add support for Microsemi Ocelot
>   MAINTAINERS: Add entry for Microsemi MIPS SoCs

Thanks Alexandre, I've now applied these 6 patches for 4.17.

Cheers
James

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqy4vMACgkQbAtpk944
dnrWSQ/9G3R2jl494WIl6nbqk/95tvveya0g9OL86xQhjs0lyUPxbPJxvFpA4Gra
227J8v4LzBzXhec5MbpfXV4cLP6HSvOqeXk8GRmUMMzw+ZBgiGYN3caig421x4sR
1+RXOO9UPxELhqUVJPHx6u3hUV5OpitT1YLZRdCNutzE+Mqi4xYM8ZUKCO/fOSZh
yOMpJjPB6FZX7zb8UJNNn6+QpF1RvFgETJlLtnbk0SkQRjhYUHzdGwnPDkLkIDvE
wui5P4LpWCu1VqaB0c7HY7a9hiTVbT0+tGK8+nq4DBZQawF+AoI90uStcEUxYkQG
8YicB5AiO6XbSuB8GRTednAgMyvnnTmVFsgtaMNPxlsE2u2PxOv6N2feE7ybGhuC
qreHj6n9Z3XALROAZR2nMCZgG9QwVN/hp1PIH4WtlLqsQ/EEg9IdqaMYM2lK2LCY
cNOPFZHQy8ufXFIwnTQ2Y1U4haF2PgWEk48K3qewkp5bqCfb5QyKMYL9fbvMIh/G
uuY7ST8c7EcDea5QdW0vZFv1qeLDPAMvVLJtkUP03B/50cqwqciV48NVBhq3EuAm
3daFhAAY4OcvCWxTaZZbv5/UtJHm/Ly4yBC1NGjwtvaivNM7Xm+lxQqgK9NvEDvs
T8DE/rFcJcS0L/p01SFmee9hsysOF8vD9Qo2b2S6FpRIsHdSViY=
=ddab
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
