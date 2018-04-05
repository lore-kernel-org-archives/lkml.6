Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDEXXX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:23:23 -0400
Received: from ozlabs.org ([103.22.144.67]:60741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeDEXXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:23:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 6 Apr 2018 09:22:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the
 efi-lock-down tree
Message-ID: <20180406092216.4579a70c@canb.auug.org.au>
In-Reply-To: <20180315183412.01412755@canb.auug.org.au>
References: <20180315183412.01412755@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I+9AFFrLTz7h9FOI4YGGEaB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I+9AFFrLTz7h9FOI4YGGEaB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 15 Mar 2018 18:34:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   drivers/scsi/eata.c
>=20
> between commit:
>=20
>   5b76b160badb ("scsi: Lock down the eata driver")
>=20
> from the efi-lock-down tree and commit:
>=20
>   6b1745caa14a ("scsi: eata: eata-pio: Deprecate legacy EATA drivers")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the efi-lock-down tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/I+9AFFrLTz7h9FOI4YGGEaB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrGr6gACgkQAVBC80lX
0GzgTAf/dknkjMfJVQOuO4lLyM7hsX1I9sY8AoSQNVdnCNCziXdacca33AGZ3g2j
hjEgd4vTJKAfsBDrVl5i9x//YFHBmZeXWALzIyuZG2asqjgx7JRY6bwJ9t1Czh9r
H6qKPJblC3KN1KKR1sUcwJxyqxfd+lM6o5s6YjdD1eT+UYigdUuJgt+2cOlahhJm
5FtYyhtYqjcgn/RZ2vjx4S00VhbgMOOpc5FOJSBXoB2UgRdTIJ4+BvDsQ6jCAFW5
/MvAmZj+KZjBvci9+6YRodg8fOtQUqZVEfEJydIJEa/9LE0VFUTQyvXLUiQ2Df3z
W4aAsVT0lZnHgPIA5VDBLiZpr9EIVw==
=ynvJ
-----END PGP SIGNATURE-----

--Sig_/I+9AFFrLTz7h9FOI4YGGEaB--
