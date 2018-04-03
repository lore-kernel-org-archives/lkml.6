Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeDCKtz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:49:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54727 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755060AbeDCKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:52 -0400
Date: Tue, 3 Apr 2018 12:49:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / QoS: mark expected switch fall-throughs
Message-ID: <20180403104950.GI6758@amd>
References: <20180330211844.GA23072@embeddedgus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20180330211844.GA23072@embeddedgus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 16:18:44, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXE4ACgkQMOfwapXb+vLkmgCbB80CiFmKMNG0Tmeor6hhbyLK
TcMAnji0LXVnZPoM7yx6f1vo8KQNh4Pe
=BzI7
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
