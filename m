Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeCPKQh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:16:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43635 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeCPKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:16:36 -0400
Date: Fri, 16 Mar 2018 11:16:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Joe Smith <codesoldier1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Guidelines for Submitting an RFC PATCH
Message-ID: <20180316101633.GA2378@amd>
References: <CABGNeczK4Jdw5aAoT62-SZsKrYTTKh+pUgMZWcCa59c5YqZgXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <CABGNeczK4Jdw5aAoT62-SZsKrYTTKh+pUgMZWcCa59c5YqZgXg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-03-12 16:01:08, Joe Smith wrote:
> Hi All,
>=20
> What are the guidelines for submitting an RFC patch? If a developer
> wants to get early input on a design is it fine to submit a patch that
> is in reasonable shape but does not fully meets the requirements of a
> regular patch, for example, the patch consists of a series of patches,
> it only compiles when all patches in the series are applied. Going
> through the process of meeting all the patch requirements for an RFC
> patch seems too much.

There are not many guidelines for that. Just mark it RFC :-).

Series that only compiles when full would be fine for example. (But
you may get complains from 0 day testing bots, not sure).
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqrmYEACgkQMOfwapXb+vLwvACgpB1MXHFf0OETYia7nFVRW4XA
F7gAn10mFUGl0CdrlVlPlUX854YAOehc
=vzEr
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
