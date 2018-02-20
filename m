Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBTXBV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeBTXBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:01:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293C02177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 20 Feb 2018 23:01:15 +0000
From: James Hogan <jhogan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 6/8] MIPS: Loongson64: cleanup all mach files to use
 SPDX Identifier
Message-ID: <20180220230115.GH6245@saruman>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-7-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <20171230182830.6496-7-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 02:28:29AM +0800, Jiaxun Yang wrote:
> To reduce unnecessary license text.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/loongson64/Makefile | 1 +
>  arch/mips/loongson64/Platform | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
> index 4fe3d88fc361..64b270c70607 100644
> --- a/arch/mips/loongson64/Makefile
> +++ b/arch/mips/loongson64/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0=20

whitespace at end of line

>  #
>  # Common code for all Loongson based systems
>  #
> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> index 0fce4608aa88..ceffdace758e 100644
> --- a/arch/mips/loongson64/Platform
> +++ b/arch/mips/loongson64/Platform
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0=20

same

Cheers
James

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMqLoACgkQbAtpk944
dnpVkA/+L/zPthBFiarZCX9WOVePDaQtrzHzgxzib9Hox7K2X9nwYJvgvuCqENOY
MPC60seSN08+/gN2ejoySsdzjuxyyoyNyYdqU7jKRT38QEYq47gOmjYFRiB2dl4U
2TKI1uhntZnr/tlkl59alll00JIvez5cMsXsE9z07+K46Yb9JnGn+7f/FVBsQR52
p5LeM3IaIkcbtCUxPfC3Opl9KKMJLT370ejkdhs0f6ptQ0uelV3hwUHEuex4uL1n
DhA7HxT9J6hCGNtLGf/x5/oRlfLhlHuEbcJGCVB+/6afYXSH6j+TdgHXbwvopI0s
NDofxAWVT8f0UIefK2RDdv3GS5vi875ktqMTKp2BM75PTe/QLVAjzwWLp7oycts2
V7Ghq9YOkAC7/DJtmZEbLJlANwcjBNOlYJDTdvqMBrTaVyUP4HpMQgw3A/tm+Dgj
8w7nRg1fEleTlufDXp3QPhAQTogT5MDBULjwH8fEvXimrpB2BKiL3ZDmlNVwHVkf
6DryeIXru9LsZDlvA/Ey6v9W0Tnng8dcjfXK+pKSJ8G9nQ64DNoRJrm+1m/hQCdo
UflxpKst1tOSfozpoFayorUgDFbp5LnnXOZG2j3JgmAbzYbhku0oeYSagR+absyj
YBEPfbbSeNwPEXziCrlHrbVswTp4CMOcrF5Pl/ydy8PhPwW6Dlw=
=HZU6
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
