Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967415AbeE2Vkf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:40:35 -0400
Received: from ozlabs.org ([203.11.71.1]:45787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967178AbeE2Vkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:40:32 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 30 May 2018 07:40:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20180530074012.393b74b1@canb.auug.org.au>
In-Reply-To: <83024e98-8719-7ed2-a5d5-e1653162bacc@kernel.dk>
References: <20180529143357.2a66b0af@canb.auug.org.au>
        <20180529081205.GB1416@lst.de>
        <83024e98-8719-7ed2-a5d5-e1653162bacc@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SqvX5CREKlQODG_3uzAwLJY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SqvX5CREKlQODG_3uzAwLJY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Tue, 29 May 2018 08:22:43 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/29/18 2:12 AM, Christoph Hellwig wrote:
> > Meh.  Do we really need these switch to octal patches to start
> > with?  I mean, I personally prefer octal, but just switching around
> > in random code that isn't otherwise changed creates nothing but churn. =
=20
>=20
> This is exactly why I hesitated doing it, I knew it would end up
> with conflicts. The main reason was to get rid of the inconsistency,
> since we had a fair mix of octal and symbolic names.

But the conflicts are all trivial ...

--=20
Cheers,
Stephen Rothwell

--Sig_/SqvX5CREKlQODG_3uzAwLJY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNyLwACgkQAVBC80lX
0Gx2qwf/YkMzvHbny1c26A2RmIIr+VRQYUDpUXCpTGhrQpAAwLLgOACPmyJDHNbF
5Vvk34hPq74T13Qm8IrmpblfD0N4g4gSxaBvsIHYjzoKwGxz9KiKhkP0uiCo2zZ2
a9E1IEc/u9rr2EMXqJ8ajD06a7Z56zJm0Vj8eYwOPP72ezCX0tOA3X6fuSQSl7Qw
OOAClSbgSWU5DDma7Nf9695NCcO9UdEeY6DEflSF4QOV2uhQnANGWuz/FkWBsPSx
Y377Xmoubm7woiVIf+gn6Js87ApmmApo2nNb81KRvr49U/qhH2G+Ex4R9BM7K2ub
LIVwTv1qcLzGOY9IFS1pqx/eysMzRg==
=Gfao
-----END PGP SIGNATURE-----

--Sig_/SqvX5CREKlQODG_3uzAwLJY--
