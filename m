Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCNUjY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:39:24 -0400
Received: from ozlabs.org ([103.22.144.67]:56927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbeCNUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:39:23 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 07:38:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Borislav Petkov <bp@alien8.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: linux-next: Signed-off-by missing for commit in the edac-amd tree
Message-ID: <20180315073851.0124d37a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t81ftmIZjWB==0Y=C3ZzJq6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t81ftmIZjWB==0Y=C3ZzJq6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Borislav,

Commit

  aefa4bb56ca8 ("EDAC, skx_edac: Detect non-volatile DIMMs")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/t81ftmIZjWB==0Y=C3ZzJq6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpiFsACgkQAVBC80lX
0Gxlegf+Nr4OVgntA0WcIYaVkWcR+c5nE9lWY4dHCWTtn+LVdkBVAyTqobWRqS0h
TOJjYo3heWCnV90C8B+whQQ3y171AP/F7dKhROj+jlRcqW/U0cq1e6s9hicLAAqi
c2KuHz4JEf8pKsXg59tyX2uyzIvh+2cftS2j450GH9MPKeqVFHOyNHISO44zhvj7
5dpqJbVvAViJlfL8eQDC2VkbrpMqyVv2lSqEFNQOsd+3qpeOJY6j4EYG+py0/6yQ
alDxHmdFplUFbWUxU7HaJX5uT/xaR2W1Vl0bNmHr3G/pKE5oveQiP4gDfN3TY1fy
8qknpZeXRm16A7SNFH22VeFpAt1pvA==
=Y1aj
-----END PGP SIGNATURE-----

--Sig_/t81ftmIZjWB==0Y=C3ZzJq6--
