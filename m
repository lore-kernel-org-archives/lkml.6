Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeE2KXQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:23:16 -0400
Received: from ozlabs.org ([203.11.71.1]:42285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932795AbeE2KW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:22:56 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 20:22:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ondrej =?UTF-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20180529202251.7db684bc@canb.auug.org.au>
In-Reply-To: <CAAUqJDu=Ez2CQY0JPTWA+K2UKVZbjRF-YFQdpP0=xmtqd7kEzQ@mail.gmail.com>
References: <20180529190846.764421ea@canb.auug.org.au>
        <CAAUqJDu=Ez2CQY0JPTWA+K2UKVZbjRF-YFQdpP0=xmtqd7kEzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yExKcb7HygdgdfjmRx62Rq3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yExKcb7HygdgdfjmRx62Rq3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ondrej,

On Tue, 29 May 2018 12:16:59 +0200 Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gma=
il.com> wrote:
>
> there is already a patch pending that fixes the issue:
>=20
> https://patchwork.kernel.org/patch/10416245/

Great, hopefully it will be merged soon.

--=20
Cheers,
Stephen Rothwell

--Sig_/yExKcb7HygdgdfjmRx62Rq3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNKfsACgkQAVBC80lX
0GzM2QgAnELJD67MNHavguNSrPxsTQGOPNXIUiBMz2mnrDgikrnQRL2VwfUrfDzJ
ovk074TZH3TsbvmOW0jLLRDNur6Y4B2sW/xGFPepXYcAFzOBGRye3qG4LLk/xGL8
SiQFunci4MlpyTwYo4GjxlPVH6Vjs65wgY9H7RCqqpO+UySoXTQeHi3/7xj0GGFp
Xkjnvy27uFUsvacDaoXCY46LYMFK8yyB/kj/Ahkm+J8bMDV3LWu2EJSbpkUELxr2
3Kou+NTTZeKef87a2KygPuCO7KZEO+ECA7AUL1EblKroqGGlX8B9eZECUMhLH10j
quDPlqjy4CztC7O+6qPXyxteyCKp1w==
=VFM7
-----END PGP SIGNATURE-----

--Sig_/yExKcb7HygdgdfjmRx62Rq3--
