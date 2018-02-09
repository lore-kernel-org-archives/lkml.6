Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x224yOAkpF4+YhrzgRhN1c8LRpb+oYRXUrZzF/79v2ZYT/Z0DsMgg6+8fTihjExdpEhGsBara
ARC-Seal: i=1; a=rsa-sha256; t=1518210558; cv=none;
        d=google.com; s=arc-20160816;
        b=O8Tm2TuKUSgH0yH9S28f6nvmEg9gCGEG3YWWtR4bs14gk8xFwbrXpwxWStviR254MO
         1aOiwjJX1//dTGtUDatRrOtI0ZmqtXH/zoxTVHz1O6IMuzOsqDFe+8iv4Dw6iRvI2UV0
         8GcnQA/MlBoKwLQZhs/mS+SBTytVmyrze5SYFgDxSNMAqSRX9IfcARi4jpV5PBUZLTHO
         OziSC4zgE7iJ2WGoLdI1s1SPDVZKdX3b4OJLpyOCc/tR4gDoiEJv3JpEpZ+rtE8qBMNB
         UY3EFiqR1rjkX9mh5KAcJ3Sfzjs88Plfji1CW2JV9nz/JV3Hs0/qaM8BjCw7HahnorWt
         9tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VkfdadkEGZs3WnISVAlFGkfnSB24HdgcHUlJm4PIOts=;
        b=tsG9XlZjtlhrK0xvdYoYpPBTi+IpeWPypXR9FO8plTlDel8QcWANj4eHRHu1ww+g60
         LrbIuu3NU9GfUD8ALMHHE9wIE1wAyKRr3Ji6+BWFQAqngCIkY2n6cezhMS+i51SxVoPV
         kIpEm3cpIslFMFcsN/CGfkyfA4b2lPpdWJPYVGIY169QGNmIhpUpeJv/LZf+3kWOOGGb
         OzeqRJgcxaP3Yn1MXuQp7sb7xmI0i4aZ5UQwGK4AoaIJl6WsWegJQwi6JX/VQ9PD4Wlu
         5zSES5rIPUHmkf+jrVQiCIp1fXqEt/g4FXEnugir0mh30MT6EEjm/4WR3V58QfJ3TeB0
         HvDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 9 Feb 2018 22:09:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180209210918.GA7333@amd>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591959154814868003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-02-09 17:47:43, Andy Lutomirski wrote:
> On Fri, Feb 9, 2018 at 9:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > Hi,
> >
> > here is the second version of my PTI implementation for
> > x86_32, based on tip/x86-pti-for-linus. It took a lot longer
> > than I had hoped, but there have been a number of obstacles
> > on the way. It also isn't the small patch-set anymore that v1
> > was, but compared to it this one actually works :)
>=20
> One thing worth noting is that performance of this whole series is
> going to be abysmal due to the complete lack of 32-bit PCID.  Maybe
> any kernel built with this option set that runs on a CPU that has
>the

What kind of slowdown are we talking about here?

> PCID bit set in CPUID should print a big fat warning like "WARNING:
> you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
> performance will increase dramatically if you switch to a 64-bit
> kernel."

Hardware supports PCID even on 32-bit kernels, no?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp+Df0ACgkQMOfwapXb+vLUOQCgsuGLg/bps5hW4emf9c2c6MEJ
DcAAn1C0vweSUfM1H+KV6WqM9hqO0T5s
=CfYt
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
