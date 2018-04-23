Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeDWVkV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:40:21 -0400
Received: from ozlabs.org ([203.11.71.1]:44891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932504AbeDWVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:40:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 24 Apr 2018 07:38:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the cifs tree
Message-ID: <20180424073840.39b99c2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0x4BARblwaYaG9txL6PrEg3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0x4BARblwaYaG9txL6PrEg3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  dee4bf3f21d8 ("cifs: smbd: Don't use RDMA read/write when signing is used=
")
  553018657de2 ("ifs: smbd: Avoid allocating iov on the stack")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/0x4BARblwaYaG9txL6PrEg3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlreUmAACgkQAVBC80lX
0Gwfngf/VvU89agBO/P/5qdMz1kNV8qLxBVyqwRXWVpGmh2Ck+N+FwAGSFO9oVK8
tyPEsgv0DCTE+m0TgnuHb+rbG/OOM2E50oPF9wDEpV8jVMv1GOpu0CM4kAempqD8
2gBasghBiN8ZD2eEUWE0JvEu+pU+Z8RJJmGHIJlCnyiC9FmGTjx5PsJczDV4RaF/
dTtvpW0/lYW+hKtfnpRWsDphhzQamDT1gDSymmLdoOjsEEXXzg4qKjcna87wsvDO
orVv9aKo638/da4958vPy5DUH1aTOoicvkMOeh74jwasJ6+W2Ohsaf+12l1lGp6k
eCiBww1k4oPmYfFsCUqF+flJv4pW3Q==
=VfTd
-----END PGP SIGNATURE-----

--Sig_/0x4BARblwaYaG9txL6PrEg3--
