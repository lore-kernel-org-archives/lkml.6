Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbeDZHT2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:19:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56892 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeDZHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:19:27 -0400
Date: Thu, 26 Apr 2018 09:19:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and
 CLOCK_BOOTTIME
Message-ID: <20180426071925.GA30908@amd>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
 <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com>
 <20180425201908.GA1977@amd>
 <1862218.3bTVVn1vea@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <1862218.3bTVVn1vea@aspire.rjw.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > For the record, I just run plain F27, obviously with my own kernel
> > > (and a tweaked config, but it approaches just being a "make
> > > localmodconfig" of the distro config).
> >=20
> > So... I do have debian 8.10.
>=20
> Does that use systemd at all?

pavel@duo:/data/l/linux$ systemd --version
systemd 215
+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ
-SECCOMP -APPARMOR

> > With 4.17-rc1, I get "networking
> > disabled" message from network manager (and broken network), about
> > half of the time.
> >=20
> > But there's more visible symptom: suspend/resume with 4.16, machine is
> > okay after resume. With 4.17-rc1, just after resume, display starts
> > dimming and screensaver will kick in. MATE desktop.
>=20
> Yeah, why not.  It thinks that you've been inactive for the duration of s=
ystem
> sleep. :-)

Well, its rather annoying. "Wake up!" (hitting a key) "OOh, I'm slowly
waking up.." (few seconds, wakeup is not instant) "and now I'm going
back to sleep".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrhfX0ACgkQMOfwapXb+vJymQCfaC1ej9uGJXFI3QYVizXVYXXB
8aUAnjtDCkfHi5ePZFpWsa0aMJbLzwvZ
=Rh8w
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
