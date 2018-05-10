Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeEJVVC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:21:02 -0400
Received: from ozlabs.org ([203.11.71.1]:33987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeEJVVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:21:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 11 May 2018 07:20:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: unable to fetch the mips tree
Message-ID: <20180511072058.2fbe785e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gJzc=CCJgvW2YcYnXbojxnZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gJzc=CCJgvW2YcYnXbojxnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

For the past few days I have been unable to fetch the mips tree
(git://git.linux-mips.org/pub/scm/ralf/upstream-sfr#mips-next).
The initial connection just times out.

--=20
Cheers,
Stephen Rothwell

--Sig_/gJzc=CCJgvW2YcYnXbojxnZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0t7oACgkQAVBC80lX
0GzjIAf9HzMFFIz3iBSsqMpHGo8aHH/ESH3XSy9lSA5r5FiWbn+5n25uyMAaSl6N
qKZDVI4kis4vbj+sE5bA3Yy5VnInAhVXOvdhrQ4TTzXSskMksMPFaBZaOtE2AJo2
03kexPt65TJBC7K65arqvNLD0SzYSqdiEh6XVQ9ccDuRJ2AtKXiYwWtxC18iWUF9
ijF+XoOo+mbygA9PQerGVynM5cqgcd71jN2sSUyPW8MG0nSB7AYBQBUrTfQ0MhN/
MXKPUkRzQySbgkH+wStO38ozhUMgqUSJCMxHGDZoSspLWpmgqRpBzgfxWHOtrRHr
svj9DEc98+07fxLhcSA9RxJG8P3Hnw==
=IVPe
-----END PGP SIGNATURE-----

--Sig_/gJzc=CCJgvW2YcYnXbojxnZ--
