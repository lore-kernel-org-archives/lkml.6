Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeCZDqB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:46:01 -0400
Received: from ozlabs.org ([103.22.144.67]:60931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeCZDqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:46:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 14:45:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180326144512.74706ad6@canb.auug.org.au>
In-Reply-To: <20180322173722.78d012c5@canb.auug.org.au>
References: <20180322173722.78d012c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y6xsWNGkUj0Qy.0ksgwbGCe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y6xsWNGkUj0Qy.0ksgwbGCe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 22 Mar 2018 17:37:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm tree got conflicts in several amdgpu
> files because there are a set of (mostly identical) patches that appear
> Linus' tree and the drm tree.  In each case I just used the version fo
> the file from the drm tree.
>=20
> You should do a test merge between your tree and Linus' tree and see what
> you want to do about the resolution (either do the back merge (I think
> with v4.16-rc6), or provide Linus with branch that has the merge done).
> Its a bit of a mess :-(

I got a few more of these today.
--=20
Cheers,
Stephen Rothwell

--Sig_/y6xsWNGkUj0Qy.0ksgwbGCe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4bMgACgkQAVBC80lX
0GwQ8Af9H1GFH4QTihz/dTbHjqJPdgqiKTSmxJbfyS24jqwaflvJanDjc3Pdpj3D
/WG+gzng9qn58tjSZU3yqsC+usPXEanwviU2nTGPQuOegEhVN88nOo9Wf7UANYtW
GweXQJQigGqCPIvUQhehYXEWJ2J9VRM9jKQIdsb1ceHQzOorIK65iMZEaufSy4yB
jhwY8gpZ0ASz74eUwP/ao6ZL7c/2GrOGv+Q8/XxK5auZn9v3cjTfDIi6MIJxpBt1
2eT+Au5IiaVcnQ4sM41wxqzsgT1N1b73WfVzu9U9gOd2F4OqqJkHasRTQlk96lzG
EFv8tN5FSkx7/qapsYV7c9E19GNu2A==
=376y
-----END PGP SIGNATURE-----

--Sig_/y6xsWNGkUj0Qy.0ksgwbGCe--
