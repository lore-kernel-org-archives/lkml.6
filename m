Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBWIG5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:06:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33512 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBWIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:06:55 -0500
Date: Fri, 23 Feb 2018 09:06:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kees Cook <keescook@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>,
        Laura Abbott <labbott@redhat.com>, Tycho Andersen <tycho@tycho.ws>,
        Steven Rostedt <srostedt@redhat.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: collecting simple benchmark scripts?
Message-ID: <20180223080653.GA1584@amd>
References: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In a separate thread, some folks were looking for some simple
> benchmarks for evaluating various changes to kernel internals (as
> opposed to the much more focused things like xfstests). For me, this
> has been an area of lore and passed-around scripts, and it seems like
> maybe we should have a subdirectory of tools/testing/benchmarks/ or
> something to collect these?
>=20
> (Or maybe this already exists and I've totally missed it?)
>=20
> I've got at least one micro-benchmark in
> tools/testing/selftests/seccomp/seccomp_benchmark.c, and searches show
> tools/testing/selftests/vm/gup_benchmark.c too, but I was thinking of
> either more generali things more like the famous "kernel build
> benchmark" or a wrapper for running hackbench to get some statistics
> out of it, etc.

Ok, I guess my micro-benchmark is too micro for you, but I like to use

"time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc -c"

I have a page with various results online somewhere, probably at

http://atrey.karlin.mff.cuni.cz/~pavel/quickbench.html


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqPy50ACgkQMOfwapXb+vI/egCff+688Yo4uHAOQsMd5gqqVbSR
Mx0An2HFbbQg21tRMlBHrhAMCKYLKbzY
=RgoI
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
