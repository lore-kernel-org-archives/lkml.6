Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeE3UiW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbeE3UiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:38:20 -0400
Date: Wed, 30 May 2018 22:37:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.47
Message-ID: <20180530203759.GA28104@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.14.47 kernel.

This is a quick release, reverting one commit in the 4.14.46 networking
stack that should not have gotten backported.  If 4.14.46 works for
you, wonderful, but you really should update to be sure...

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
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
      Linux 4.14.47


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsPC6YACgkQONu9yGCS
aT6sLQ/7ByMG/AZMI2lzGdb4Tp2Aj3uypbFuhL+L3VBjEsIK48CxkKtD7SN02PzY
sTsPEQM7XWkWtniMWVQr0L9nOoU47Zn8ZY40F6Tnf1vie54YFBWUwIIqowe/RiOs
9D9qAtDRyahnBEVQoGR1vLhI6CuIxKDwUUqfAM9KHurQXEDtqHPWIeqZ6P/tZUEn
k9LHZ8Z5zaAVgHy4kqWCTyprVHBWdwxjwuzWRF9noKz7obujJRkB63L/2iiy7qlY
aiYVprz4MZ+BbqutRMWWq4hp5YTFbNosNptiyJxMOTE5PMFLXwTlVC2cizOhXlqz
le+ofkpe8L+lRFsDTZr98uoCs1KOUJhHX1QQ/HaNNu8RV71DEdaL5sCInBwWQ5zH
oVd6HydQyNlkNL03pG4phMNr6g5Or/YvP2cmKtkZ3QZkilfhbo/ntmx1ZAuK3v2O
HIl+v/cZhRNbJXIsxTpmkcyjnVpgNNI784oIgZKC7S90m5GnEFKcZPJ7LI6Rm0p3
/vW8Tzw4GrMscXBJJuML7T60jZlQKobQYkZVQKGUUF0eySiUzkDE0gMPCE9I66tG
aaULdJ8GEpedyGb0Obz90Lf/rEynu7/JBglbWUi/svuJBPV84kFsEjQgd88oHe+1
FlpyytQp71UpQr6SV9vu64U3hAyFNOHn2hF+4U+csEfGiQ15RVA=
=bRjR
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
