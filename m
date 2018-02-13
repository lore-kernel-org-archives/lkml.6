Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x226vtz7ANhMdSMUwn/LZgNaduBnBDaxKWhn2uZiIVXpZlkgZAt2AhgCQX29LG+yNxh+aWQQE
ARC-Seal: i=1; a=rsa-sha256; t=1518555880; cv=none;
        d=google.com; s=arc-20160816;
        b=ZvI+1fuDnMIcvaavNw+twZPyLDamz3srFvcjHXw0i5OLAaKvfFLBglQEejLbDregRV
         D407Im9KOiQwKVCw2JbARd8JaPveAtsNRkm7ExWe6sEO4OlBzxJtI3T68pB2j1XbhOly
         5ToUR0NGR0UNKAzqhilNRKkaAgc58yCPH2yBfu1AgfxbF+v5WhZZo86XMeS9SJ8GF9tK
         wcrPgzLezpelx/n414M1SlN0G8Sjes7TkBfUohjyUMaa3lxg53PZ3V2AuAvYUT4jdSwz
         iasr7UM6KMMocd2G7+hdhyI7279qb+4ygcj7GfhSK8i/pn1MsrUN2VnmjpOs6IHAX+a5
         oaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sThUQ7I5actU64qWFrQcCluvsqx+KULDwYSH+mi88tE=;
        b=HxJiDIM7Usa/SaSFAjYbUWafShznvTbfdjvcVu8hxvzKGxUWTSXKNdxhtoRNraQBAc
         P2jOb7JpSuWnah4nXzq74UkxrjbeU1Q4WXkpKZDwLQXpP23mmf0Tapa+1egOfyVkMzPL
         9vsBMEmaAwMFzmC58fnzFKeJFR8CAaaBje/8eEYCzcZyr9mUOwqHt1V2EFFgWQXRMYXG
         Ai+FnVCSbFDe1XVI94wz3xrXU1z+U0zZeXGG6UZgwjpjlYKXRHMMh2LAmLLR0jclE2dJ
         TI+8TpsCf13YIGwuqBvXnA1ZrB8Zt5O3l4y/sCTcK2o8YtUM6JslcNCcQy0VJN8OnZC/
         rK0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 13 Feb 2018 22:04:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: whiteheadm@acm.org, David Laight <David.Laight@aculab.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180213210438.GA6569@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
 <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <201802090941.41782.linux@rainbow-software.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1592321250788924436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > You might think this absolutely crazy, but I would be willing to test
> > such systems if I can get my hands on the needed hardware that I lack.
> > I am already doing sanity testing on Intel
> > i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
> > clone cpus (Cyrix, etc).
> >
> > While few people are using the 32bit kernel, I don't think we want to
> > kill it completely just yet.
>=20
> I have a working Cyrix MII (was actively using it last year, now upgraded=
 to a=20
> P3-based Celeron). Some AMD CPUs too - K6(maybe -2 or -3?), not sure abou=
t K5=20
> and also a Rise mP6. But never got a WinChip.

I'm using Core Duo daily (backup machine, web browsing), and use
Pentium M as an ssh client say once in month.

> So the question is: what to test?

Self-compiling kernel is traditional stability test.

I do have two Geodes I believe, but the hardware is quite nasty to
use. (One has some kind of forth-based BIOS -- forgot the name).

> BTW. Kernel was not able to identify mP6 CPU 6 years ago, patches were=20
> ignored.

You may want to re-send :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqDUuYACgkQMOfwapXb+vJBHwCgkedcvWa3APomnAdMKAxTm19g
1+YAoKeemFW2mWPogmzG44VoOjqXwUfr
=Vhep
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
