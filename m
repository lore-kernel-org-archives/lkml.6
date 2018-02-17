Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x225p+5MsUvKo8Vlx452jK8gdH4ndydixY8gCFrJVNRrYRocM7tTVuzqRJOYZrqEH8G5ErJr5
ARC-Seal: i=1; a=rsa-sha256; t=1518902175; cv=none;
        d=google.com; s=arc-20160816;
        b=s2lVqGUePs0qofLzR5iV9y4SXcG27fZjLanw5HZiLHG1iKCUbbO+a1qdIrRcO/0mVD
         mysoXfAxVCLGCiaB40hnFCNBQZnuurhpwIlpbpM8/wrSz/ZimqPeNLTkA2HI0VEaeJOH
         Fl7DD713M7qu5nY1w/k1rCjtM/HsvxkMkcgktk7Ie7k+ql9AdLf4bucJJ97y2uQuIUsR
         dHbnaLyRKCzykFH+HLI/eUZJpT/TxIhRBsCRg8xx7cJ2SLj1vYO0KnlRC1qtR94ap7Mk
         4FpNZJ5BFdz7Env8a/+NDkR1RR2WbZne62ltAu13kkCp9rd5hI2ZOw9DpvBNjuVvGfg6
         ujLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nn9SaDNmSGEUU/MbARX2nMalDuhmZLcW+Ddwz4VmDuA=;
        b=0CZYoIHOs4DG4xNE3kgwX44WJc631/+3QnI1Teo/6L2l9Ybzr5AodLrqR2O7Qh8vci
         tcrMP9FfBYaQyZE+fxyS2F2hXjK7gsn37A4iEPYs17v3Q6zmilXUwmqSR9oYNvr4XJtj
         BAAil4KzwbVmRaAvPsUIPbwWiY0qT83645plvbgxiXyibUDSv0Pg37qo3m4DQRjHo2wI
         3SCljVVgOk901UKVV97eSMzZEtmCGMgA9qflEA8tySv6EOIn02loOZyy/CKgOhwXXwfq
         PMh4yowQQZwSpdl/lPxu47UrW/wOr6i5/FBSj54A9IWQjgbG/05ovaPMpM433jES+pwU
         Rq/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Sat, 17 Feb 2018 22:16:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: whiteheadm@acm.org
Cc: Ondrej Zary <linux@rainbow-software.org>,
	David Laight <David.Laight@aculab.com>,
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
Subject: Re: What was last kernel that booted on hardware XY? database was
 Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2A
Message-ID: <20180217211623.GA9543@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
 <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org>
 <20180213210438.GA6569@amd>
 <20180215095320.GA2112@amd>
 <CAP8WD_ZuYCZW42DXeunS8NvKdSA739Sdrr_oBaxJn7MxfzrNAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZuYCZW42DXeunS8NvKdSA739Sdrr_oBaxJn7MxfzrNAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592460207317318961?=
X-GMAIL-MSGID: =?utf-8?q?1592684367578991035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > BTW... I'd really like to have a database of machine, kernel version,
> > cpuinfo, config... So that questions like "what is the latest kernel
> > that is known to be running on this hardware" and "what config should
> > I start from".
> >
> > For example, I have nokia N810 here. It was supported by Linux at some
> > point, but then we moved to dts, and stuff changed, and I can no
> > longer figure how to boot it.
> >
> > I guess "what was last kernel that worked on Cyrix MII" is also
> > relevant question.
> >
> > Is there such database? If not, would people be interested in
> > contributing if I create one?
> >
>=20
> I am interested and will help. I have i486/i586/Pentium Pro/Pentium
> II/Pentium II Xeon/Pentium 4 systems to test on. Oddly, I don't yet
> have Pentium III systems.
>=20
> I think an associated goal would be to fix those broken versions.
>=20
> I think this is a great project for college students to get experience
> with. Who else is interested?

Ok, I started something:

https://github.com/pavelmachek/missy

I try to test -rc1 and final versions on thinkpads X60 and X220. (I'd
like to do testing of even -next from time to time.) I do have T40p
and test maybe every other version on that one. I test Nokia N900
quite often (including next), and plan to test N9/N950 too.

Of course, more "exotic" hardware would be welcome. I did have linux
on sun4/330, unfortunately I don't think I have access to that any
more.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqIm6cACgkQMOfwapXb+vKNzACgkahAQpCn91LDx1j7hzqX+6EY
OP4An3WgF8eVCwK/f9bPK0ai4jg2Qg9T
=qCtL
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
