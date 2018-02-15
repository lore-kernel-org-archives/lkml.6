Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x224mlTcbAjI0pqDLE2KmCIBMbW1rYgAeZSW5KVQjjqQ8/gm8d61i5IkqhW1azvFMdQ+5TtbO
ARC-Seal: i=1; a=rsa-sha256; t=1518688399; cv=none;
        d=google.com; s=arc-20160816;
        b=Zq/QzEWMUjcvFqi0+xvQxXaGXIJ7bzP4ywAlnld3x69gDFOyUXw8acHP+aSpTDu9kD
         KoZPYCqkXot/hZk0Fmev5iR2CbqAXfHdKGTT+nu612CZu/Hy+hwgd7FR0xzD06UxHtiL
         mAldKvHf07vPbv7Dg8cn87vLNvbz5o3EP/sfOYLhC5kaaPwRVh3VLXl7ItUZT4nlgLDG
         xE7TWD/izTG1EN22a5e/WUpnZAiaS6PGyY1W28dDbGJcgDRI4diApMqIgFQDSx/+sr2Z
         CaVaHvEiqDfl5J2xWboNX3XeR5IlUismksklUDKQFWXRV4nzDavcxFFApqaHhIGDfvMi
         ZCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ehIpdg09faqhdX7TNAoAkJRS2d5ugv0bi34Bf7FfFdQ=;
        b=sRVDl8G5rgMEUftNhoDDstz/VuGJavhIwysjVEeU8ste1rxzkY1stGhRb6HT3rjqzD
         kwnKVfCi9nBnbj2OknkWdq3P1ej+Ie7tx8mS2NZ2YLPNBiweTGfCt0bTYahD1tIcVoN0
         eJhkL8pbgev9wgY0JwgSQ2rewbYsPgY88M5u70iDD2tpmML+yoZcYhIU1CsAsr4ykqfo
         7uY6oK+4gwu0hGGFZQzMFJAMbtjfXFMi2sLPOpWsv/WjLL5n2WRWqICdUeKxhOXybaCZ
         y2ahpD4IRF3eHfjQmczpQroLQaiUnZUstU17d0CLf7fVGn6qH4VZinDLbgjOxNmT+4fd
         WNBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 15 Feb 2018 10:53:21 +0100
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
Subject: What was last kernel that booted on hardware XY? database was Re:
 [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2A
Message-ID: <20180215095320.GA2112@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
 <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org>
 <20180213210438.GA6569@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20180213210438.GA6569@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592460207317318961?=
X-GMAIL-MSGID: =?utf-8?q?1592460207317318961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > You might think this absolutely crazy, but I would be willing to test
> > > such systems if I can get my hands on the needed hardware that I lack.
> > > I am already doing sanity testing on Intel
> > > i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
> > > clone cpus (Cyrix, etc).
> > >
> > > While few people are using the 32bit kernel, I don't think we want to
> > > kill it completely just yet.
> >=20
> > I have a working Cyrix MII (was actively using it last year, now upgrad=
ed to a=20
> > P3-based Celeron). Some AMD CPUs too - K6(maybe -2 or -3?), not sure ab=
out K5=20
> > and also a Rise mP6. But never got a WinChip.
>=20
> I'm using Core Duo daily (backup machine, web browsing), and use
> Pentium M as an ssh client say once in month.

BTW... I'd really like to have a database of machine, kernel version,
cpuinfo, config... So that questions like "what is the latest kernel
that is known to be running on this hardware" and "what config should
I start from".

For example, I have nokia N810 here. It was supported by Linux at some
point, but then we moved to dts, and stuff changed, and I can no
longer figure how to boot it.

I guess "what was last kernel that worked on Cyrix MII" is also
relevant question.

Is there such database? If not, would people be interested in
contributing if I create one?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqFWJAACgkQMOfwapXb+vITKgCfVyLbktox8K5aYyR76eM6TQcF
JNIAoLHlaajmhIKq4h/rahKDs63cac+g
=ZAXA
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
