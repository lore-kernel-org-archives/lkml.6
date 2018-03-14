Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeCNFAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:00:13 -0400
Received: from ozlabs.org ([103.22.144.67]:52549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeCNFAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:00:11 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 15:59:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the syscalls tree
Message-ID: <20180314155943.673fa73a@canb.auug.org.au>
In-Reply-To: <20180314155725.581ee5ca@canb.auug.org.au>
References: <20180314155725.581ee5ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dfjSCkW5CrqGvM39zf+0+Zt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dfjSCkW5CrqGvM39zf+0+Zt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dominik,

On Wed, 14 Mar 2018 15:57:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the syscalls tree, today's linux-next build (x86_64
> allnoconfig) failed like this:

kernel/fork.o: In function `mm_release':
fork.c:(.text+0x1a17): undefined reference to `do_futex'

--=20
Cheers,
Stephen Rothwell

--Sig_/dfjSCkW5CrqGvM39zf+0+Zt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqorD8ACgkQAVBC80lX
0Gw/oAgAhcqiW92kwyOawdeY/jn9w02UAhQF8hBr8pHJoS88u4y6xsfy9FXqXk6O
RTtckMCJ4fSIiSmdxJpy1r6gEEEfhGlNcedwGn5wPi9HG0Rg9qo3HKgtpkBfM9K+
b0rXJc7HKzlhA4KP+9Qn/1TY9a5AEhKENwq3V4kiiJ/2xcv6FPQnpf70PpX6Mjb5
Prminj37PrOEkOVkQg3xwM8B6A2zDJXyYxFNKf6aBBzhlx54yKsrquQbn6E4+k8q
EocIawHnwqJX2dKwS3m067J/ovHZ5lQV3pp6faEY7VH5Q2rP1JQOvbxyWu8kuOh/
OKOfOZI8KrVT3rtvZ2Ou9GFq1H7azA==
=TCms
-----END PGP SIGNATURE-----

--Sig_/dfjSCkW5CrqGvM39zf+0+Zt--
