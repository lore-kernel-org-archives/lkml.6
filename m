Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x2251FRXadew3RiksCppPnzk8jsuVVlf4uYAETXJx2NcZ2WPr6TcYJQM/KqhCdYvdm47P4c3P
ARC-Seal: i=1; a=rsa-sha256; t=1518555887; cv=none;
        d=google.com; s=arc-20160816;
        b=K0uDyt0rHMAKMipXuB6DScK95TSZm7N24McbWUWwiCaaXFzzqyJMMYV1dz4w5JqF71
         5gvqRkfx08hRP+pRdaV0iGykM4WPfOviTfuYInw+GyP7OWt66WBlGxi7nC1bXqETgTv3
         yVe86fyNWDq7ezBLXeP7UjypsAK9QvnNTBj9ACKHIUV0OMm0eiR3OjkbOhrkTms1O+GZ
         vU4a4qfk29a/0Q3CoLIer5uaB7c7RYDAq+MkvzvcK63g0iajmQ8NwL9dx3AxVkvxCEw7
         0i7lg4LVpKGu46XbEsHnJ77ZdqjA6z9WbWMuZzntDvqcv/QpUpDPi/4ZEHNEJEF1rmQq
         Mwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DVOR2TbPhXMke7RIvyEthGIjHJsqiz9p3KKRGoERABo=;
        b=hDYazZjyPb5wsaI34ZBC8XTyV7mNTHv1nmNtFBCyPqwWOSehgXikV+SRgWx7n1BKtW
         TJTplaVLFzDmYLoQjGFa9bC+mjkd7z8DS86D2MytrSQKW1JHih+fr2ZU6Je28SM9V9KY
         2Ii3e37NihsBDLkR7l5KNWxPgOzfR5W7EAop2wStDLL2qbY83NB9IRLISBE0+YgnfiZM
         tULdOuF2ioGzRpX6onsO5c2AH1aMDlKWcgftPJKQ8oRlU0WJJoXLevVEF7O8mS9CrSAh
         TVaK9RgH2VgEb1dlrVeUcH4sgOqyzILwM5QVBWTdrkDKd8p4jYTNq3FNCa01oQXjIRGY
         kgbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 13 Feb 2018 22:04:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: tedheadster <tedheadster@gmail.com>, whiteheadm@acm.org,
	David Laight <David.Laight@aculab.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ondrej Zary <linux@rainbow-software.org>,
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
Message-ID: <20180213210448.GB6569@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org>
 <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org>
 <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
 <CAP8WD_bF4jFQL=hOXRx97cyciq40MTJ9j8QwvJzLsn+LQudkmg@mail.gmail.com>
 <20180208205240.0c53631f@alans-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20180208205240.0c53631f@alans-desktop>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1592321258578962845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-02-08 20:52:40, Alan Cox wrote:
> > > Also worth nothing that the difference between the cpu and memory
> > > speeds is much lower - so far fewer instructions could be speculative=
ly
> > > executed while waiting a cache miss.
>=20
> But they also have more instructions that take a lot of clocks and are
> easier to stall - eg by doing things like opening and mmapping
> a framebuffer and then doing a floating point double store to it
> misaligned.
>=20
> Meltdown we can at least reasonably test but spectre is hard.

Do you have pointer for simple meltdown test?

I've got https://github.com/IAIK/meltdown.git but could not get it to
work even on machines that should be vulnerable.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqDUvAACgkQMOfwapXb+vJOxwCcD6LBvq0LQ4K+5eB5YrMtAcB0
fFgAnjHZFKzAx94oBpJSDeDyy6waCEjA
=mScl
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
