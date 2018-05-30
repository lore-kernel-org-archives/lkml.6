Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeE3UXE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbeE3UXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:23:01 -0400
Date: Wed, 30 May 2018 22:22:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.112
Message-ID: <20180530202240.GA2585@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.18.112 kernel.

This is a quick release, reverting one commit in the 3.18.111 networking
stack that should not have gotten backported.  If 3.18.111 works for
you, wonderful, but you really should update to be sure...

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
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
      Linux 3.18.112


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsPCA0ACgkQONu9yGCS
aT6r4g/9GnxuosSkuQoHDMruVbfRM+HlLMmMoxxVisshRnxHaKno5HCh18L++9a6
g6pH5heLw6oLzsOxonh5iHEWsauea7YV86zVS9EEEOObmqU4zesqAKEpiIvFMfqk
F6mBdgGzgfFU626g+Rr9SR5829kmJZmcgObAs3WVSYnpx9NzuVdWYu2XF8T/ljw6
i4G323RnUc0kT9CqwPEiUOXaP4iq/E7oXA5JRTVi8YzaNVYFvqf3DTJmLwnErzW7
67xK6Tn6aehNUdzAgvw0IWe+oEXvqwhHEtOZIrX6LmTsBKmXVJRhV6dp08CIHYsa
w4eV7+Ulm/dHcZa151krWeZpjUR2e6glkGrIBSxNPMEMsEVdz2pMcXqUweSIHIaW
/ArMdeQk9sYLua4Dcgbt15csyYACZYvOIpqSGXdDGt8M5kucEUv6P/bmpLqUZV6r
IctGC8AR0yrK3nDIhN+WSTcD/9E8PZrpM7SICHkFod8s8SzkX9cKHGXnCL8ddYIL
yOzdrstftfg50UqPf22XupzpEkarhCJtyQtIalFa7ZJbx3C2Ta5J62kxmSVA7GbW
0G1ILQo/Gz5IHQwyEOzN/gcyjeZ+qkTphgaq/S7t4Wg3zE7KL0JXfjyKU4elRy6f
u3skCwG2D/T9ZhzQefL9TqSfCPD4E4WR8Zpl6VeFNwO2EMF1TDU=
=fc8a
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
