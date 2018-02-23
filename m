Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWJxJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbeBWJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:53:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35DE217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 23 Feb 2018 09:53:02 +0000
From: James Hogan <jhogan@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Colin King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: irq: check for null return on kzalloc
 allocation
Message-ID: <20180223095301.GL6245@saruman>
References: <20180222180853.11505-1-colin.king@canonical.com>
 <dba1d5b6-d568-c1a1-5e6c-7a00da3d1e01@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline
In-Reply-To: <dba1d5b6-d568-c1a1-5e6c-7a00da3d1e01@caviumnetworks.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 10:10:30AM -0800, David Daney wrote:
> On 02/22/2018 10:08 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > The allocation of host_data is not null checked, leading to a
> > null pointer dereference if the allocation fails. Fix this by
> > adding a null check and return with -ENOMEM.
> >=20
> > Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>=20
> Acked-by: David Daney <david.daney@cavium.com>

Applied to my fixes branch with 4.0+ stable tag.

Thanks
James

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqP5H0ACgkQbAtpk944
dnquzw//VizcEzcb175yh9w/aAkX32RslfjWvO87s8+78qDYNkW5MECM1iJ1RqKX
MMnyBu1tUC+rwnmCA4Rug8JgufRQZ2WHcfCYDZW6Bh+TBHFzR0ZmY61Qrmpnyrni
lia4pM1uOz7DFOKby7l9jYyi//9TeAK+gjDGWgu2dVYbmVKnppZkcEGnN5MJNSzl
u5zFi3DHCJJnBmgyXxOr/p6LGRCU+Asgn70ry2EV6Swjn56fmGKCdlKRl9O4KTbF
WnHRaQ/gobmLbS6tRrzvQtYzxTof73Yqu2pG8k8AImWFZKIYNbx1yNnoEOIQ72GT
jE/lUdbhmT4okPMBKTvN6lTJ2GJZ63XKu/EyhM7GeUtbeuIrl+2toTgBf7E5hf1U
YdwXjHgTmUlm6ctqPKffNAlpYGzT5SVxgzZOlvqOcsmc8TSuOzw8s1IRMDvfuFeZ
O8qP+UG0reVvJ/jpo9CsxpwIbCQX18yE8smcRJKz3urx62IAzyW+IsBUPtXpHRkT
NQl2wP4NUPF7ZIhpG/SGpWxrbPOLiJn95Ug8QNZkcjrM8t36U3zRjCtxskfgI9Wd
nVVy/L26d7Q7oxJd0wZNzz4XMvDVo3ynlVW91AYdkklXrrT5p759G1S2h94SjrTP
AH89bDl4FDBfNYp6tgKxsnjq9ESRJYTDl6WfWlJbBa9SF0xA3aI=
=j8OB
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
