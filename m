Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeEBFuV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:50:21 -0400
Received: from ozlabs.org ([203.11.71.1]:57997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbeEBFuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:50:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 2 May 2018 15:50:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "Linux-Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180502155014.4f5acdcb@canb.auug.org.au>
In-Reply-To: <0942C278-336F-4795-BE63-FAD7FBAA231B@fb.com>
References: <20180502120921.654cc338@canb.auug.org.au>
        <0942C278-336F-4795-BE63-FAD7FBAA231B@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S_M1RAlcT1kN14QJvW+92YW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S_M1RAlcT1kN14QJvW+92YW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Song,

On Wed, 2 May 2018 04:40:20 +0000 Song Liu <songliubraving@fb.com> wrote:
>
> > - 	CHECK(build_id_matches < 1, "build id match",
> > - 	      "Didn't find expected build ID from the map\n");
> > + 	if (CHECK(build_id_matches < 1, "build id match",
> > -		  "Didn't find expected build ID from the map"))
> > ++		  "Didn't find expected build ID from the map\n")) =20
>=20
> ^^^  Is there a "+" at the beginning of this line?=20

No, this is a merge resolution diff, so the ++ means that the line did
not appear in either parent commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/S_M1RAlcT1kN14QJvW+92YW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrpUZYACgkQAVBC80lX
0GyfMgf/TX4gdDqM4rEbYNUQ7x6XsvDvo4sZDQTMS2OiI/RlRJE3HR3A+IzbIi/f
cIMBpoQR4EmNie2Zj/YRvwvMfFqJz1Ce47W85KWOmHghXgG9WQbHN40khS++9dIV
QSkqx9XfU6EGa2Li4Glmqyu901jt9xPNeYpYpau293pelf8+lh9IEqOm38+717JZ
qV3A3rkSO0NaClafP1agRpLYE4vU358XX7KROFqEPkIeIoTMXRr/DXgrlVjT7jrE
ATXMa+5Ch7JZV8Ufj5lvdgy5h93DOQEah71xLbu+fFtY1eHb1t0IogTJaHyYQv5y
L1hGokQ6vO0anRLWOeKgGNQTRBaMQg==
=rOmh
-----END PGP SIGNATURE-----

--Sig_/S_M1RAlcT1kN14QJvW+92YW--
