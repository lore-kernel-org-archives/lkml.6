Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeCVMKt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:10:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50941 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeCVMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:10:45 -0400
Date: Thu, 22 Mar 2018 13:10:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
Message-ID: <20180322121043.GB12518@amd>
References: <20180319154124.337947038@infradead.org>
 <20180319154717.652679334@infradead.org>
 <20180320094554.2bc49dea@lwn.net>
 <20180320155036.GU4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180320155036.GU4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-03-20 16:50:36, Peter Zijlstra wrote:
> On Tue, Mar 20, 2018 at 09:45:54AM -0600, Jonathan Corbet wrote:
> > On Mon, 19 Mar 2018 16:41:25 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >=20
> > > A primary prerequisite for this is of course that the compiler
> > > supports asm-goto. This effecively lifts the minimum GCC version to
> > > build an x86 kernel to gcc-4.5.
> >=20
> > Given that, how about a patch to Documentation/Changes to reflect the n=
ew
> > reality?  It's not in RST yet, so you should be able to go there without
> > ill effect :)
>=20
>=20
> That thing says:
>=20
>   GCC
>   ---
>=20
>   The gcc version requirements may vary depending on the type of CPU in y=
our
>   computer. jon
>=20
> Which is still entirely accurate. And afaik the 3.2 minimum listed there
> still works for !x86.

Maybe accurate, but pretty user hostile :-(.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqznUMACgkQMOfwapXb+vLEPgCfbAGhFnaihiqpafa//lb+oBDS
r6oAnA6UD9NcB9hwOR3YI4G2r8ERXEoL
=0ynj
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
