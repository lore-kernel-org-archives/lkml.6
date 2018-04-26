Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDZAyj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:54:39 -0400
Received: from ozlabs.org ([203.11.71.1]:60339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeDZAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:54:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 10:53:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180426105313.792db06a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wkK=wWAY_vDnI.2KmtHVDJz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wkK=wWAY_vDnI.2KmtHVDJz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  samples/sockmap/Makefile

between commit:

  4dfe1bb95235 ("bpf: sockmap sample use clang flag, -target bpf")

from the bpf tree and commit:

  2e04eb1dd1ca ("bpf: sockmap, remove samples program")

from the bpf-next tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wkK=wWAY_vDnI.2KmtHVDJz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrhIvkACgkQAVBC80lX
0GxxhAf/VEYT/aZ+dmt+YE3vXjuNJtLgzG8Z4XF5kTKu0ARypNI5SH0y1PPoJHlj
r7RWCfrrr/nbhuqnYasnAyDAgw9Dm8M+WqZktTLkPDedN3Ct+VV/YVtj7C/x4gR+
sO3uY6SbV7Nds6S0LETOQ4QmfnOr4HZ41MptaSAkmy0u/BETMs0S7DtNECeZJbd2
6jHo0DRCzEE148vzCe6nshpnOLxDBc5cYzbErHuiwlX+GrZ5OHPv3DfeQREA0JX+
S+KniW/evQ/Bpo59FO6P53sSF34mgbX+QAsoSB0OjVC0z2MRqnsHJyH04IFzAMYR
ViLvJB7n/yiTuaI8GFn6ijJcL/lDiw==
=D7ap
-----END PGP SIGNATURE-----

--Sig_/wkK=wWAY_vDnI.2KmtHVDJz--
