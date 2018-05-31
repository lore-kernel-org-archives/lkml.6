Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750796AbeEaVmf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:42:35 -0400
Received: from ozlabs.org ([203.11.71.1]:50513 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEaVmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:42:32 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 07:42:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@redhat.com>, Alasdair G Kergon <agk@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20180601074216.10ae824a@canb.auug.org.au>
In-Reply-To: <f5842a01-2bf1-2c18-1531-becae5dc5fb6@kernel.dk>
References: <20180531142302.5f7b4302@canb.auug.org.au>
        <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
        <20180531121041.GB8456@redhat.com>
        <6ad38822-0bb4-3099-69b0-7a8a36d79403@kernel.dk>
        <9ed288cd-0e85-1cb6-7be0-d9d76c7af66d@kernel.dk>
        <f5842a01-2bf1-2c18-1531-becae5dc5fb6@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1RdPe7KjSgXwEJ9yH9mylA."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1RdPe7KjSgXwEJ9yH9mylA.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, 31 May 2018 09:02:01 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> Talked to Mike offline, but for Stephen's sake I'll reiterate here
> too. Since I'm assuming that dm-writecache is the only problematic
> user here, and since Mike based dm-4.18 on the block tree, I considered
> it saner to leave things as-is. This means that the API removal is still
> in the tree.

Understood.

> Stephen, if you see further conflicts due to that, do let me know and
> I'll do a proper revert of the patch instead. Hopefully it'll be smooth
> sailing from here on out.

Yes, thanks, will do.

--=20
Cheers,
Stephen Rothwell

--Sig_/1RdPe7KjSgXwEJ9yH9mylA.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQbDgACgkQAVBC80lX
0Gwh/wf+Ns+X6n6O5Wnn/nAyUfu5NjXx6PEbB7sLFfvrPMpwwEzEWoUm/FJb7HQ+
aJODeeDqAEiJY14+cyT79zQPgiAnuQWQYByyLBT/lFIXVXE1fCJPUUAmG1VUgbhg
fd/n/yo0xS3WW7j0GNDdN8O5RSpCzddzlLR1JIP7Rd5Ee+RPZAcCreW7xXX9fBnR
Nnca3d8aFDnnXdMUldRf+xr6rC7tUZy1vK6QMTqGGrEwuT0O1mk7Uub5ZY27rpTX
7x8q9MsZzhbv7SWQC5esCVNLLnud1GkFm1ulOCYs3Z5TRyBcRYM7GMP3XC1TpX/i
cqsO0sju/ix+jqN5OgBlA1ZKKPqGag==
=i4fw
-----END PGP SIGNATURE-----

--Sig_/1RdPe7KjSgXwEJ9yH9mylA.--
