Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeEQAjn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 20:39:43 -0400
Received: from ozlabs.org ([203.11.71.1]:36827 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEQAjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 20:39:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 10:39:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build warning after merge of the vfs tree
Message-ID: <20180517103932.3d7014d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hMiEqv1IeAmIv/pC_idrwj/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hMiEqv1IeAmIv/pC_idrwj/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/isdn/gigaset/capi.c:2344:14: warning: 'gigaset_procinfo' defined bu=
t not used [-Wunused-function]
 static char *gigaset_procinfo(struct capi_ctr *ctr)
              ^~~~~~~~~~~~~~~~

Introduced by commit

  2cd1f0ddbb56 ("isdn: replace ->proc_fops with ->proc_show")

--=20
Cheers,
Stephen Rothwell

--Sig_/hMiEqv1IeAmIv/pC_idrwj/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr8z0QACgkQAVBC80lX
0GzjNQf+OQNY5dsyKGqqVazQZJhTgbKu9hfiEeNASyXx+p9C05o/6DKCpHY9l2xV
EiuoTbQwMwEE6R9zQgsk/ocsh4uuoDNYiEC2MKS8yV5L/GBuIKIHHKXuRmpMu7wT
7c7LIDNCpIx2UZYRHYfU8E2I/ZeoCwSm7ai/B57tBdmTyPv7C3PfotJptXCob+ra
uB0J80qHOSv6HX/w/cvpnctwi/J81vrjELXjpaYHneKfciVwR1mVBljt6Od6P+so
6MyQVEBIFd32AFM8Td3k2YkLwm+Oz396zdw9IXmc9X0dckucXSsrR1MGrMzrc+TL
hUx4tH6bU8HOeuVLMLyJ7WaqtKp0AA==
=XU5q
-----END PGP SIGNATURE-----

--Sig_/hMiEqv1IeAmIv/pC_idrwj/--
