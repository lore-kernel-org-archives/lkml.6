Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x2251HldgeE12qRrP4QkIC2GuiTE3X4q0aGNjFfKx61m5bjxAEXOBRXtkuaCDxWNr4gbplNFp
ARC-Seal: i=1; a=rsa-sha256; t=1518605023; cv=none;
        d=google.com; s=arc-20160816;
        b=0Iib1yVqK3rj+Kp9q1Bi4kOEMukqSYVzJW/7XTlyA/VWIjBwOyBtSvkdG+YhPY9yY8
         Zi8pXlG73PS/0iwdqeWc4wY0C5F5rB1eSKcvXXbLA31sLfGgVP1KLmhnWJTs3DiVdaGD
         aNoOtj+27u6ygJ/1R9xy58OXrKpMT/iF56BpT6/Pz6/2QUcreLwhQaB0NkQXameohkk7
         U6gGOVPBoWCwjXlzlWWGVY4bA9ZDckZ/InLQYL9MH86syjmGN/xU4JzF49x4ScvW+HP8
         G0Mcfh+J9DQLYsD/jpXDaJKTZ3jMboILEjxC+ImF3XNYxFDopaNUxmk08/3O9Fn+sAbC
         mZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=wgNfUhtyxJwR6OOyA1l6i/hrqjnsQY8hlmZdgkU/MFk=;
        b=M+AF+9bzegOZpu9rM4ErsQRxSHD1I72dxRx/X6+p4mf1wxgWZAaUYam6nhEEZcoUbh
         +gEsLOTuOS6spSpbllsg10FGCAIClgZ+WYvrPlipvaM1cDuV/a30EFSNkuFrXlJsfKTe
         gvmu1DLKVU6jnqLLqAyjzQ/m3+TqVRMUgyuf4Cf5pdkG8BlYrw8FXymPVmVc3TsC0Gho
         ARrGrNM3gGWMq86cfIb40h+Gxh7CM53QsId6s8Sr2MZlBCQ1IY7IIddZwD/YluS65KnC
         fRdnud49vjgOdZnRSEm138X/h+J+k9imxk1sDeg4rk6lvevz51fFv81+9sZzFEiKM2hB
         Uc+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Wed, 14 Feb 2018 11:43:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mark D Rustad <mrustad@gmail.com>, Adam Borowski <kilobyte@angband.pl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
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
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180214104342.GA12209@amd>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
 <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl>
 <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <0C6EFF56-F135-480C-867C-B117F114A99F@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592372781010625396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-02-11 11:42:47, Andy Lutomirski wrote:
>=20
>=20
> On Feb 11, 2018, at 9:40 AM, Mark D Rustad <mrustad@gmail.com> wrote:
>=20
> >> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> >>=20
> >>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
> >>> 32-bit install?
> >>=20
> >> Quite easy, yeah.  Crossgrading userspace is not for the faint of the =
heart,
> >> but changing just the kernel is fine.
> >=20
> > ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit=
 userspace. I remember someone offered kernel patches to fix it, but I thin=
k they were rejected. I haven't messed with that stuff in many years, so pe=
rhaps the userspace side now has accommodation for it. It might be somethin=
g to check on.
> >=20
>=20
> At the risk of suggesting heresy, should we consider removing x86_32 supp=
ort at some point?

We have just found out that majority of 64-bit machines are broken in
rather fundamental ways (Spectre) and Intel does not even look
interested in fixing that (because it would make them look bad on
benchmarks).

Even when the Spectre bug is mitigated... this looks like can of worms
that can not be closed.

OTOH -- we do know that there are non-broken machines out there,
unfortunately they are mostly 32-bit :-). Removing support for
majority of working machines may not be good idea...

[And I really hope future CPUs get at least option to treat cache miss
as a side-effect -- thus disalowed during speculation -- and probably
option to turn off speculation altogether. AFAICT, it should "only"
result in 50% slowdown -- or that was result in some riscv
presentation.]

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqEEt4ACgkQMOfwapXb+vKwvQCeIXEkHk0gIuij6jJeJ8L9JpaQ
OVUAn2Jr3gvFOK5Qz+8M3nnE2T54bLHV
=30Yq
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
