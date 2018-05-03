Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeECGT2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:19:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36681 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeECGT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:19:26 -0400
Date: Thu, 3 May 2018 08:19:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Laura Abbott <labbott@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180503061924.GA6999@amd>
References: <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org>
 <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
 <20180502162653.GB3461@thunk.org>
 <3851ac8b-357d-3c82-2195-936e3c459212@redhat.com>
 <20180502222522.GA15457@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20180502222522.GA15457@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-02 18:25:22, Theodore Y. Ts'o wrote:
> On Wed, May 02, 2018 at 10:49:34AM -0700, Laura Abbott wrote:
> >=20
> > It is a Fedora patch we're carrying
> > https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.=
6.2-fips-ctor.patch#_23
> > so yes, it is a Fedora specific use case.
> > From talking to the libgcrypt team, this is a FIPS mode requirement
> > to run power on self test at the library constructor and the self
> > test of libgrcypt ends up requiring a fully seeded RNG. Citation
> > is in section 9.10 of
> > https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validati=
on-Program/documents/fips140-2/FIPS1402IG.pdf
>=20
> Forgive me if this is a stupid question, but does Fedora need FIPS
> compliance?  Or is this something which is only required for RHEL?

If RHEL needs it, Fedora needs it, too -- as Fedora is a beta test for
RHEL.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrqqewACgkQMOfwapXb+vJ2uQCgpfcVgw1AoDGqcuNDOaXsEUiS
YZ4AnjWKisjQ9fOeb4oYpt5v8SDBjJWn
=DLvf
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
