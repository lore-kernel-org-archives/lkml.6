Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeCRKk2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 06:40:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48394 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeCRKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 06:40:26 -0400
Date: Sun, 18 Mar 2018 11:40:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: Netdev list <netdev@vger.kernel.org>
Subject: linux-next on x60: network manager often complains "network is
 disabled" after resume
Message-ID: <20180318104023.GA10392@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With recent linux-next, after resume networkmanager often claims that
"network is disabled". Sometimes suspend/resume clears that.

Any ideas? Does it work for you?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlquQhcACgkQMOfwapXb+vL50wCeMsJykRLMDJ2eCf1pIKFtIgBp
uKcAoKRXiht1B4ehkcZr2/VndouIdkp8
=UqP1
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
