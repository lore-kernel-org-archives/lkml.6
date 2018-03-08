Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeCHAhK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 19:37:10 -0500
Received: from ozlabs.org ([103.22.144.67]:60083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933935AbeCHAhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 19:37:09 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 11:36:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl
 tree
Message-ID: <20180308113647.75279391@canb.auug.org.au>
In-Reply-To: <CACRpkdaWd_7QWd7t5i6DvU3_Gu1giR9v2uoqQiLNXVWTPEty8w@mail.gmail.com>
References: <20180308073921.5c104e74@canb.auug.org.au>
        <CACRpkdaWd_7QWd7t5i6DvU3_Gu1giR9v2uoqQiLNXVWTPEty8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fPX23p+65JglBHjx_00rr7J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fPX23p+65JglBHjx_00rr7J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 7 Mar 2018 23:25:48 +0100 Linus Walleij <linus.walleij@linaro.org> =
wrote:
>
> On Wed, Mar 7, 2018 at 9:39 PM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> > Commit
> >
> >   fc08fa6009a0 ("pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT p=
in in pinmux_pins[]")
> >
> > is missing a Signed-off-by from its committer. =20
>=20
> Looping in Geert,
>=20
> I guess this came in through the Renesas PFC pull request.
>=20
> Geert do you prefer that I back it all out so you can send me
> a new pull request? Or some other solution?

But you are listed as the committer ...
--=20
Cheers,
Stephen Rothwell

--Sig_/fPX23p+65JglBHjx_00rr7J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqghZ8ACgkQAVBC80lX
0Gy8ZAf/QWwQ8GKG7GLgDnkAvk3Pp7zF0N+cqMN5iz7J0s8kcnoiNS42iegfus/h
5h97ggHsBo2zDNbeKqO0jDywOcuP84uGZ6lPt3Vk56/be7OgXyx6SoNSmtWyuqOP
OZBMpilQzYarOFP8lGPAcwdyZDw5WFqraCh7zIyESZWFf5uOYdNtGi7tZDoPwh5m
6tabb0mDCa7JH60jAAZxH9yP6DBfha/wn36Nds0TDMFED9WACXjPUeUN0vocjKns
eDexZPvHQFbXHGFGMxAdA1bXfEhAcDpf8/emwNz1/++oxiHBeclSGu0DZcXlPBqL
Ybo/ynu5jq7unRUQCmvD36DNTbAmFw==
=SMLf
-----END PGP SIGNATURE-----

--Sig_/fPX23p+65JglBHjx_00rr7J--
