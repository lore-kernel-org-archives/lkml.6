Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCVVeG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:34:06 -0400
Received: from ozlabs.org ([103.22.144.67]:53737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeCVVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:34:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 08:33:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: please clean up the alpine tree
Message-ID: <20180323083315.58976d73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2IV5wW/2i0j_PavOz9IjbOK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2IV5wW/2i0j_PavOz9IjbOK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

The alpine tree
(git://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git#alpine/for=
-next)
only contains commits that have been upstreamed as different commits.
It also hasn't been updated since late March 2017.  Please clean it up
(it takes some time to merge - presumably just because of its age).

Or, if it is no longer being used, please let me know and I will remove
it from linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/2IV5wW/2i0j_PavOz9IjbOK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0IRsACgkQAVBC80lX
0Gx62wf/ahhhKNL4e7QdHS4yy+ZnqasYtHlqjrH2a+X9QqOuKB57XTOv2U0I7v14
MdAXQouxZsmKXZZc45+NLYEqX8+Tno4inaitqjIkIFvOzKhasmRLii0DIMeHtWU1
w3HA0v+YosFYx57C5ID1VkKKfrqJhXxnBHaTJqeKasUcxwWp1sA7MnaXosxZNGGp
OM0tFBRrM9hO/dfRSG0HilHZj1IsKyUiWboAd7ISVxpr8fKWbJ03YbQvH0DIN3sa
bYzf/bJFFkFBmo8jp5yIxDSnwBv4zxqnEdMWJIrZOYkxdS+4IoV/PSzGuuJa2jDC
MR1cVjR8GF9y5UYss8/u+srks4xgyQ==
=y75j
-----END PGP SIGNATURE-----

--Sig_/2IV5wW/2i0j_PavOz9IjbOK--
