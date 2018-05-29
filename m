Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeE2GEV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:04:21 -0400
Received: from ozlabs.org ([203.11.71.1]:36329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754569AbeE2GES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:04:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 16:04:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the devicetree tree
Message-ID: <20180529160415.5da54b08@canb.auug.org.au>
In-Reply-To: <CAL_Jsq+nbTv-bnjo=OQR+P49MgjwL7qkcc+47=jRHb4z0V94Vw@mail.gmail.com>
References: <20180509160449.68b865a2@canb.auug.org.au>
        <CAL_Jsq+nbTv-bnjo=OQR+P49MgjwL7qkcc+47=jRHb4z0V94Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xGvQJ8uUMEfKuePU45zux=E"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xGvQJ8uUMEfKuePU45zux=E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, 9 May 2018 07:17:06 -0500 Rob Herring <robherring2@gmail.com> wrote:
>
> > and over 2000 more :-( =20
>=20
> I assume you mean on other files. I've already sent out patches for
> arm and arm64 dts files.

Yeah, we appear to be just down to this now:

arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (graph_endpoin=
t): /soc/mdp@5100000/ports/port@3/endpoint: graph connection to node '/soc/=
hdmi-tx@4a00000/ports/port@0/endpoint' is not bidirectional
arch/arm/boot/dts/rk3288-evb-act8846.dtb: Warning (graph_endpoint): /dp@ff9=
70000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-evb-rk808.dtb: Warning (graph_endpoint): /dp@ff970=
000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-veyron-jaq.dtb: Warning (graph_endpoint): /dp@ff97=
0000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-veyron-jerry.dtb: Warning (graph_endpoint): /dp@ff=
970000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-veyron-minnie.dtb: Warning (graph_endpoint): /dp@f=
f970000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-veyron-pinky.dtb: Warning (graph_endpoint): /dp@ff=
970000/ports/port@1/endpoint: graph node unit address error, expected "0"
arch/arm/boot/dts/rk3288-veyron-speedy.dtb: Warning (graph_endpoint): /dp@f=
f970000/ports/port@1/endpoint: graph node unit address error, expected "0"

--=20
Cheers,
Stephen Rothwell

--Sig_/xGvQJ8uUMEfKuePU45zux=E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsM7V8ACgkQAVBC80lX
0GzWCgf/dvr0oYnLxzYXLCnLiv/at4ML7V6MPa9mjfwVMkZ324eQKMP+kbTq7TEp
ndm86b42YXCL41ErG37G054+veq1yE7fvpEj7cgVodkBjbp4K7BiWH1IKeE1+4tq
1xVDL6jCDG+p7zzdKuxcs86QkRGbxv5vbIt4Cz7q1EvSHtT2CmN2vfCZ1pOVs8pt
pMuDjdfRQ13Dl9guJRBBxzza7RM+4IZ5MrDk6/sRVlfbJ+t5CC1YYEbjk9GNVKL5
t3cAqoliK9yQpoICIfPNmosBKwXODJ06aQHU6IbyrLtF5mG1OQr4NGk9rsDfsPMo
30pt6VILOCo6JqlKLV5PndrBehesYA==
=d4NB
-----END PGP SIGNATURE-----

--Sig_/xGvQJ8uUMEfKuePU45zux=E--
