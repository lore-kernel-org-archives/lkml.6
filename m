Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4/i2RfXvJNkD2EWOCrxmv9szl/Ai7mqlBPB4eWHd9eoUmvLZuLPDjcEIHd5x7sQJARjMKhy
ARC-Seal: i=1; a=rsa-sha256; t=1524391233; cv=none;
        d=google.com; s=arc-20160816;
        b=KSmcr5GM+4BlzB24tVz5H/5H9+Hj/jTax5Yre6KlRVffxn3mcqzh7vcIqrmaygr6uc
         GEO87AgI4VcTp4i6lAFoKTvxbptdVAdVEzmjLxwXFkwtr/O+HW9K+ELP1ij7wuU2wo5t
         a2wiABfRedQPnuAptR9xkr8NC8bVxzq1q9kZqvCHzOfcge69EUXzxHTnc6MLx6a0t/Qx
         k+wqZbqCyLBwDpAMU0aN9rH8I5g6GyHkwpFyy/1QmT7o/cMJH+7mK3tY9VG9Tih1TTDW
         GNTKdK/TPuxtS7El1N8bDIQ9+oDZiiycZmk+4wIOwiKHzDHeb+r6sKa7c+1aaw51fo+x
         iniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=37a2nsIG6nXZvInt6gimfVYhUjDfsLaIZ7ZBPm5P+Eo=;
        b=yxFsripxno+Yzkid+dZbObaQSZ+z48NvtUVCYBxmOyfUyn83jQjPWhPv1PlvKdk4MW
         itMp4sGjCDRDAgv2dbOKqKRV2XJ5z8HJ7x8zRHuU+xyPqHrIPDq3MXOU1dyGSGSHH5uK
         hxZCe0KcVT7L3S8vdx4GTpyh1ecsenrYsk9r+VY+Y0Ybq4G3BH0ZEBKopSiZ9wcIrZl0
         tFMcG+6CCM8Ya+44xPy5+FuZQWZh416/UXq/QqgIbj50FcISwErf6AEyw2PTCScyrhJ/
         3MXrPAM6aO+wb5O8SdULQ+VfnWuTI7V7zw/AVxzSFleyNOKq4E+f8NUcDb9odKbr1DCB
         Cijg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Sun, 22 Apr 2018 12:00:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Lutomirski <luto@kernel.org>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
Message-ID: <20180422100032.GA18114@amd>
References: <20180307214624.D4361772@viggo.jf.intel.com>
 <20180309204526.56301f43@alans-desktop>
 <CA+55aFw5+KjVqKUpAMF+-BfE6NuXSNb8qdRtmAWDq6apK2v+sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <CA+55aFw5+KjVqKUpAMF+-BfE6NuXSNb8qdRtmAWDq6apK2v+sA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1598440062356816440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 2018-03-09 13:15:31, Linus Torvalds wrote:
> On Fri, Mar 9, 2018 at 12:45 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wr=
ote:
> >
> > If you want to be taken seriously then I think minimum you also need to
> > - Give a GPG key for messages to the list
>=20
> Oh, I don't want to be taken seriously by people who use gpg
> encrypted email.

Heh. I see that gpg has some usability problems, but we do encrypt our
http connections, and email is at least as sensitive.

> > - State what security is in place (encryption etc) to protect the list
> >   itself
>=20
> That could be stated, but it's worth noting the other rules.
>=20
> If you have some long corrupt vendor disclosure period and are worried
> about any good guys finding out (the bad guys probably already have
> it), we're not the list for you anyway.
>=20
> Keep your "we'll keep security problems under wraps so that they can
> be exploited for a long time" emails to yourself, or send them to
> /dev/null.

Umm, they will not sent it to /dev/null, as that is not encrypted :-).

I guess I can act as this kind of /dev/null. It might be useful to
note the issues, and for the serious ones notify you few days before
the "long" embargo is going to expire...

Best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcXUAACgkQMOfwapXb+vLi2QCbBRWS347sf1bbosIBKDAAw8KK
FGcAnAttXd3u+EJx2kS05Umez4/P6Nsu
=2kt8
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
