Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeE3UhQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932176AbeE3UhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:37:13 -0400
Date: Wed, 30 May 2018 22:36:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.105
Message-ID: <20180530203651.GA27847@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.105 kernel.

This is a quick release, reverting one commit in the 4.9.104 networking
stack that should not have gotten backported.  If 4.9.104 works for
you, wonderful, but you really should update to be sure...

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
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
      Linux 4.9.105


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsPC2MACgkQONu9yGCS
aT6ejw/9EpCb1Vq7wJP0ppZMcWK85VoZzY3F5rh3oOb6MrK2L4gAwBFOxI+TVfpH
C5NiiYl0FhzSX74rcfiAzjkEwJpywhuH5dqbCTxC9N+ODWl2Mhu/CxJXddT2aJhr
Vw6n8FMwfYoOEcK+rR0tO5HuZRg2Ny4OCf+TWaH/gOBRo3lWtSHAvQilpFEGTyeu
azNCWjbZlYm3aNZZWrYPetVpU21kEJhcL0SXNYkj0yGvrFxq1Ve1ieiKOZwrEYqb
f0qMl0jUgV9uJAJ7FY4SU4tJobttgPQLDxTz1jRiLHZ/T+01O1UPU1gJdjBmqOG/
OQW+AIx+s3yy93/aA87R2XJXADKGl+MAGb9LKShH8aPlPx2DHetO3o2038JmR7iD
y4tXden4Ea+VLg3GfltQKkqaHV04bocXltg9D3zLQAuSQchWQjiMTHyc9AmfsY7C
vWnaiNYSOynPtniXDGaiGfGhbExmA9FTfkqQiz1DzxkSluSBJ/JrMv4DVaEOWdqT
t9NYD57DK3aeGjeUEORK81aYCWnr1ZxPwjewAl9LvV4eQQJW/Ic5eV/Jmc21u/YB
cwapmgCboPfDyc7RfqyZiJNhj0G+yKjmMLMKCzqGloPHDpw+2YDFhW8HBfJKf7jl
ROywqEoCW9qmg4wxJ20PcAHCQfs7gkefLfQYo3eERIu+lr2qBtA=
=7PlH
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
