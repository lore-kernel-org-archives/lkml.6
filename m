Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeEaEiV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:38:21 -0400
Received: from ozlabs.org ([203.11.71.1]:56699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeEaEiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:38:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 14:38:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20180531143816.01af2db7@canb.auug.org.au>
In-Reply-To: <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
References: <20180531142302.5f7b4302@canb.auug.org.au>
        <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m3jcP865iScaWobYI.If3oh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m3jcP865iScaWobYI.If3oh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 30 May 2018 22:35:40 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> I=E2=80=99ll drop the last patch, we can do that at the end of the merge =
window instead.=20

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/m3jcP865iScaWobYI.If3oh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPfDgACgkQAVBC80lX
0GzGIwf/eahZ3GVKsRnWnwYyLhmJ+ztrNnFTeTVy6wvlQ4PYaVdCaM6amHopEDQQ
5TF3ZjC1cyDLj8gruB5mOPeZyiyMBAdw6xRtCx1Q0mb7xR9x+2r12PK9wxll1yy8
5f0QmhTVI1GTY6c7ya5Pg/luZjuM/JyZWWI6/PZDS6F+07+NVVuGA/wxMpRvxjLl
/TnKWCQ3r5j3NsEMeSR2T7GAN2wVrXW5OofxqaCK/ICSPwOrE3W3IWFv3ebn/Np6
Sit4TM3VfZ0iNXwCcVec0RNAvjdhTdrd6ONmsSea89XjrBox1ZWwjkJhE3Did/6k
Rw/H4p4a3wgdR+/RByySlHA2+e9V9A==
=rtCm
-----END PGP SIGNATURE-----

--Sig_/m3jcP865iScaWobYI.If3oh--
