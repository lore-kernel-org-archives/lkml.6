Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeBVA3f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:29:35 -0500
Received: from ozlabs.org ([103.22.144.67]:52001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBVA3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:29:34 -0500
Date: Thu, 22 Feb 2018 11:29:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greentime Hu <green.hu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pull Request for linux-next
Message-ID: <20180222112931.7001de9e@canb.auug.org.au>
In-Reply-To: <CAEbi=3dGZe8S4pH-jwCZNm4EDA6FnJdUgPZv3CMPRgD=7SpH4Q@mail.gmail.com>
References: <CAEbi=3dGZe8S4pH-jwCZNm4EDA6FnJdUgPZv3CMPRgD=7SpH4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gfy3wqy3os.DYUUmaoVzl.m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gfy3wqy3os.DYUUmaoVzl.m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greentime,

On Wed, 21 Feb 2018 16:14:39 +0800 Greentime Hu <green.hu@gmail.com> wrote:
>
> Could you please add https://github.com/andestech/linux.git next
> to linux-next
>=20
> I will be sending pull requests to Linus for nds32 to be
> included for 4.17 release.
>=20
> https://lkml.org/lkml/2018/2/14/423

OK, I can't actually use your tree as it is at the moment.  It contains
a set of patches that are copies of some commits in Linus' tree - it
looks like a rebase gone wrong.  Please fix that up and try again.
--=20
Cheers,
Stephen Rothwell

--Sig_/gfy3wqy3os.DYUUmaoVzl.m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqODusACgkQAVBC80lX
0Gy8lQf/ah9rccIR3dKzhuecXXbIWGjsXxFRb09wqIMU7F0OFusFgaYheQjdjory
y5RyfpDtSVmUso/pSArZ33kgaAAqTrKawE3rIvMP7yupY/AlsZYfzAu7lEiwJ5MY
do9419oPqgQzIiK1DpCZ0QcvVTiG75qkXOxWyKcnEBYsToL8VGTRgZjMoIw+LhYv
Ok6Tkjo23pn7qhp3hIR3RFWmKQLauOYoItn+OixpvosEFjZPllUW6NwaN6xJUo4A
xmI7YFKwvbLcV6kJQRRNjOMe9qq+GXJSA9Ybp0qBj60iwQwJNIFe7TzTLcnPUXVt
4+0nwrhfqRu0zqsDpCoZurmxX0gtbQ==
=Y5EO
-----END PGP SIGNATURE-----

--Sig_/gfy3wqy3os.DYUUmaoVzl.m--
