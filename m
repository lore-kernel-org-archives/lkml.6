Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCQWPx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:15:53 -0400
Received: from ozlabs.org ([103.22.144.67]:39997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeCQWPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:15:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sun, 18 Mar 2018 09:15:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rtc tree with the asm-generic
 tree
Message-ID: <20180318091501.3843a277@canb.auug.org.au>
In-Reply-To: <20180317132252.GG4123@piout.net>
References: <20180315185917.3316d781@canb.auug.org.au>
        <20180317132252.GG4123@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/by.UMozGWY0z6u7sj7xHdR_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/by.UMozGWY0z6u7sj7xHdR_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sat, 17 Mar 2018 14:22:52 +0100 Alexandre Belloni <alexandre.belloni@boo=
tlin.com> wrote:
>
> I've removed the patch from my tree as there is no point in modifying a
> driver that is removed.

Thanks for letting me know.

--=20
Cheers,
Stephen Rothwell

--Sig_/by.UMozGWY0z6u7sj7xHdR_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqtk2UACgkQAVBC80lX
0GxrdAgAkFcpgLuc53J6qzBfxp3xpfUOFWLqDUGU/ZKIAgz1wQ8k3/xXT3CyJZ8N
PG288zabPr+p7GaN3zurbfey4x5dRCvc7zxErelNnStn7Rl5CGptSPGOQ3UFWl5X
vs8H+wc3ITiUzCZSt1ISFnNsiZdYi8TqBBSSLWDOJJ+4PMDDwQ1MiZ770avWAio4
OcZYSY7rtq9EOF2pGPHU554d6EFKz6k2dcJEprCODhQz3nq8ASvgxVcWzFftl2a+
5ZSs9Ozy1b5XbQN0AJlpWviisfCxWd48DuGl0Nhf+JnUC/5xBKkKBdYPj1NJEud3
boXmnzVA8zJ6JeQU60Jhg6D6cEicyw==
=UrXE
-----END PGP SIGNATURE-----

--Sig_/by.UMozGWY0z6u7sj7xHdR_--
