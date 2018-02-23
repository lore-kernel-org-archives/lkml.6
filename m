Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELsYKWYSwQDasVZ9XwzyckdagEdj3NmJkX20bJmFtSZDK/9qJq6hLQCEtN5Ckejw+NHY/Rbd
ARC-Seal: i=1; a=rsa-sha256; t=1519373223; cv=none;
        d=google.com; s=arc-20160816;
        b=NiTjvLywC+hHWnPmKIyp3dxNBUmEf18kWcDBC5nT7+s5suTRFBCi0kBJJroFIDGJrf
         /F1fn4+K3IVZzD8nD7fjdPFR1i3yRgubDu+3SGi+Pq059tZSBqoTKKjPjAR0e9NPmUzj
         rPqPuRbC11m7IQs6yMghQ+xz/CBfV/wqWtAZowN2tl8hBmAFCfI9aBIgU1DanlxkIIAK
         Wg8/WK5lDwlNrvNQvxPhkslEfDyrWm56wbWeH2KkVVxODDQa2KbEPaHg2gbxCpYVR1fD
         /EpyxvgKekb/pA3g8Kqc05Ea0SfNhKWWC8kpgzD8NG7t0uwLIbi9k5ypzVQzLjv70oTI
         1NcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LxA8Q0cac81FtZb2yXTJt6UZqlyMCLSVSBdzL9B2jG0=;
        b=w9ulRgdPtfnX5bCVZC14hzzscshM6KNSCmW7M07yt+tYgTrln4BI+gAm7DX3dowSbS
         cjtykBhz7xgzq2GJyhei9qWdHDp38wQSIcmXUbc1qrwnomlkhIVTHxKh4cJxYJQJu2/E
         QSogIlzKU0iCl+EGgRjiLpFkFd79ClzBK3w4F3wfTchQA13OEcG3U0unHPtR9qcnDcol
         qg5btfT1uYWkBkBuq/H4GoC0GcGkr0JnifNbJQEfwePSOZkHciCXZPkSfreCEKnW5ltJ
         e77Vq+mSAY6JDzrmIjpdMCJn1Ih37lkb+WUPGeY02J3MyNNS2fwW0WFpOQfN7Jra48i/
         i9BA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 23 Feb 2018 09:07:01 +0100
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
Message-ID: <20180223080701.GB1584@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
 <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org>
 <20180213210438.GA6569@amd>
 <20180215095320.GA2112@amd>
 <CAP8WD_ZuYCZW42DXeunS8NvKdSA739Sdrr_oBaxJn7MxfzrNAQ@mail.gmail.com>
 <20180217211623.GA9543@amd>
 <CAP8WD_ZCFbCHwf97Zs0ZgkN5iWs2t7=6HuGXfM4g5Ze5VJK_Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZCFbCHwf97Zs0ZgkN5iWs2t7=6HuGXfM4g5Ze5VJK_Og@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592460207317318961?=
X-GMAIL-MSGID: =?utf-8?q?1593178297088510225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > BTW... I'd really like to have a database of machine, kernel version,
> >> > cpuinfo, config... So that questions like "what is the latest kernel
> >> > that is known to be running on this hardware" and "what config should
> >> > I start from".
> >> >
> >> > For example, I have nokia N810 here. It was supported by Linux at so=
me
> >> > point, but then we moved to dts, and stuff changed, and I can no
> >> > longer figure how to boot it.
> >> >
> >> > I guess "what was last kernel that worked on Cyrix MII" is also
> >> > relevant question.
> >> >
> >> > Is there such database? If not, would people be interested in
> >> > contributing if I create one?
> >> >
> >>
> >> I am interested and will help. I have i486/i586/Pentium Pro/Pentium
> >> II/Pentium II Xeon/Pentium 4 systems to test on. Oddly, I don't yet
> >> have Pentium III systems.
> >>
> >> I think an associated goal would be to fix those broken versions.
> >>
> >> I think this is a great project for college students to get experience
> >> with. Who else is interested?
> >
> > Ok, I started something:
> >
> > https://github.com/pavelmachek/missy
> >
> This is a good start. Could we start to create a hierarchy of major
> architectures next? I propose the following:

For desktop PCs, I guess grouping by CPU type makes sense. But I guess
I'd prefer grouping CPUs by manufacturer, not by CPU "family".

So I'd propose

pc/intel/i486
pc/cyrix/cx486
pc/amd/am486
=2E..

> You would put the computer you tested it on inside one of these directori=
es.
>=20
> This will need to be edited if you choose to use it. I left out items
> I know little about, such as Geode GX1, Geode LX, VIA C3-2, VIA C7,
> Transmeta Crusoe and Efficeon, Winchip-2, Winchip-C6, and certainly
> others.

Advantage is, that even if you know little about the chip, you know
who manufactured it and how it is called :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqPy6UACgkQMOfwapXb+vLZnACgtQsLjpqT2a8L35ZdnUvCxC0d
3ooAnAnj/f6xQkSK9uEmnINiKe8T8m5p
=gqPH
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
