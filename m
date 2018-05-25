Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967423AbeEYRa3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:30:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39848 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967305AbeEYRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:30:28 -0400
Date: Fri, 25 May 2018 18:30:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 24
Message-ID: <20180525173025.GO4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owpTafYe/1tj88Rh"
Content-Disposition: inline
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--owpTafYe/1tj88Rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

This tree is being released on the 25th but it's actually a snapshot
=66rom the 24th that I started building on the 24th but didn't go as
quickly as hoped, sorry.  There should be another linux-next done by me
for today (25th) as well, that will appear tomorrow all being well.

Stephen should be back on Monday.

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a defconfig for arm64, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf.

Below is a summary of the state of the merge.

I am currently merging 277 trees (counting Linus' and 64 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

--owpTafYe/1tj88Rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsISDAACgkQJNaLcl1U
h9DB8Qf5AcHDdPUQSdAJbJY6eWQkTXM5GZVNX5vVcydIq2YyELW9NxcgFZ3V/R1H
2ggMlKi735zRMZKKz6NWauivf03+72DeSTwzKluVuuVi1PlzHGpmhBO4GRBPG1hN
1TA/+QXhAG72gDuoPjFvmwPaiEWllRIlf2h6bYpAUXZ9omFcblgmV+Nm/gsmq+lP
y6xxPMOakiiIPNGVFRUbkTLdpzGbnxKXsiwxo/0Xrm7G0k0Vg8fYh6F1oPEoWPFq
oiBBjTIE2bz0z8DW9dCZ+ijKLoBhPZ9zQGyyGte0oULdTt1AgWzfYsvTzpEJMK5h
1pQxSlorx+1FGUZmitxzmfKMkb8bog==
=r4qJ
-----END PGP SIGNATURE-----

--owpTafYe/1tj88Rh--
