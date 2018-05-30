Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeE3UXy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbeE3UXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:23:51 -0400
Date: Wed, 30 May 2018 22:23:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.135
Message-ID: <20180530202331.GA29582@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.4.135 kernel.

This is a quick release, reverting one commit in the 4.4.134 networking
stack that should not have gotten backported.  If 4.4.134 works for
you, wonderful, but you really should update to be sure...

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile          |    2 +-
 net/ipv4/ip_vti.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (2):
      Revert "vti4: Don't override MTU passed on link creation via IFLA_MTU"
      Linux 4.4.135


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsPCEIACgkQONu9yGCS
aT4o5RAAsNFopUbrXgPun46OOcDPhuDwdMbmtzOKGfubU994wAuYPjRVs1hiAlCS
MIBo6h4asDd7odAjfl2T6a63yxU/OPsjrRyAYcJdvPCgBNkHop2PvZDt1AUXZULi
FGUv77whB1nqXTES6ODxmvmu4uO9W4+RWhTG7+rrhxKyTYFOmArtvzJCiGTMxCqv
+kSuyosvQfv6Zom42Dz4B8er/XUPwsu/XJFfGrIgZQPEp1c5SiSccNXx7rX2lwSi
BWn34Thx9IaGyOfAQggMHG/ZmP3SY3NnNu70Tk2a2cqrHn7yy7QqIKqSIWqsM/ra
hTeUlyQqgAfRBq1a1aNOTIjnfhlf78t91mRHNzeoY9hKfY4nQgx1saxg0sEszDD2
kgdAVTXHFQY75WWeQI0b/zX1BKHUbXEqkQPw4OWNfAFypIWJxuDb24bxp/KmA1wb
kKPXnjxvzicM/DiDwXQ6TI+8Uyx4frMCV75QAaxAotIAzisrqAnodxw4YngzARFh
UFX9iiT5Kpg1FHjHST5LvhdzX9rm8uB23eV3AGxh0w6k9yJzFNV74p8V1+ebnMbA
4euZ4b9+7/kCG6lAv3H3AEV7h7zSeSG6o/Q5M2tkTRr/IPLlu2w1mG38yzmgu0U5
UJ5UqXFfdM54V18+o36zBP+f//Yo6AXQ72jqxADUwEGW1oF5QYE=
=1d87
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
