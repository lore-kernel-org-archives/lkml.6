Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDDHuw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:50:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59331 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:50:50 -0400
Date: Wed, 4 Apr 2018 09:50:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Message-ID: <20180404075047.GB9342@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20180404165559.4cd0c12c@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Please do not add any v4.18 destined stuff to your linux-next included
> trees until after v4.17-rc1 has been released.

On thinkpad x60, suspend does not suspend at all with this -next
version. Previous versions suspended/resumed fine but broke networking.

Any ideas? I guess bisecting on next would not be easy?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrEg9cACgkQMOfwapXb+vIqTQCgkKTm03QvrJlJu/vS1Hv4PrmE
mdQAnjOF4HybehpJqY0cFnYQuogd8PJu
=yUi4
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
