Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeCCVGx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 16:06:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54166 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932149AbeCCVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 16:06:52 -0500
Date: Sat, 3 Mar 2018 22:06:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        ricardo.neri-calderon@linux.intel.com, rkrcmar@redhat.com,
        Janakarajan.Natarajan@amd.com, bp@suse.de, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
Message-ID: <20180303210653.GB22392@amd>
References: <20180108201017.GA20588@amd>
 <alpine.DEB.2.20.1801082125530.2253@nanos>
 <20180108230355.GA25349@amd>
 <alpine.DEB.2.20.1801090043160.2253@nanos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1801090043160.2253@nanos>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-09 00:44:30, Thomas Gleixner wrote:
> On Tue, 9 Jan 2018, Pavel Machek wrote:
>=20
> > On Mon 2018-01-08 21:27:25, Thomas Gleixner wrote:
> > > On Mon, 8 Jan 2018, Pavel Machek wrote:
> > >=20
> > > >=20
> > > > First, what is going on with X86_BUG_AMD_E400 and X86_BUG_AMD_APIC_=
C1E
> > > > ? They seem to refer to the same bug, perhaps comment should mention
> > > > that? (Do we need two flags for one bug?)
> > > >=20
> > > > Next, maybe X86_BUG_CPU_INSECURE is a bit too generic? This seems to
> > > > address "Meltdown" problem, but not "Spectre". Should it be limited=
 to
> > > > PPro and newer Intel CPUs?
> > > >=20
> > > > Should another erratum be added for "Spectre"? This is present even=
 on
> > > > AMD CPUs, but should not be present in 486, maybe Pentium, and some
> > > > Atom chips?
> > > >=20
> > > > Plus... is this reasonable interface?
> > > >=20
> > > > bugs		: cpu_insecure
> > >=20
> > > We've renamed it to meltdown already and added spectre_v1/v2 bits for=
 the
> > > rest of the mess.
> >=20
> > Could you explain (best with code comment) what is going on with
> > X86_BUG_AMD_E400 and X86_BUG_AMD_APIC_C1E ? They seem to refer to the
> > same bug.
>=20
> Sorry, that;s really not the time for this.

Ok, is there better time now? The code is a bit confusing...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqbDm0ACgkQMOfwapXb+vJeSQCfWe5MIt1G5x54yMolLm6ceP+o
7JYAn2IGEaxyBP/leE32dSczuxOcMz/E
=G9BQ
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
