Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756380AbeDXJz7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:55:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40096 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeDXJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:55:57 -0400
Date: Tue, 24 Apr 2018 11:55:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: How to disable Linux =?utf-8?Q?kernel_?=
 =?utf-8?Q?self-extraction_=28KERNEL=5FGZIP=2C_KERNEL=5FBZIP2=2C_=E2=80=A6?=
 =?utf-8?B?KT8=?=
Message-ID: <20180424095555.GA11868@amd>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
 <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
 <20180422205208.GA8672@amd>
 <20180423170230.GA22412@amd>
 <20180424020824.2vsddcdndjnvdm46@angband.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180424020824.2vsddcdndjnvdm46@angband.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Actually... Compressors usually have a mode when they store the data
> > uncompressed. So you should be able to prepare .gz image which is not
> > really compressed inside, and thus really fast to uncompress.
>=20
> I can't seem to find any.  IIRC xz format can store uncompressed blocks b=
ut
> the tool doesn't appear to expose this as an option.

I believe most compressors should be able to do that. But yes, that
option would need to be exported.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlre/ysACgkQMOfwapXb+vIV0wCgqV2JU39rmhHdQgg3DMJL8AnR
N8YAnik3JqJPG8xUCXekzOcEZwnVeK/U
=mHAS
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
