Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4/Og42A9TzNhmz+e6mPi4L1x2kS53NMWGyI+l2YhGERJIYMfTiPa3uByHbUkEBQPvFMFr1L
ARC-Seal: i=1; a=rsa-sha256; t=1524512306; cv=none;
        d=google.com; s=arc-20160816;
        b=RnZRdIkgUFUHWdIZQ4Z5C8q4i1sFpvHdjIwC0GTFby0PAeEcNdw35mRLJqEnuzlW+H
         4gCnfXkW5dDzXJ1mpr8Vr0FR5AjU0gangvl54ZE8u3NkmXptX4fhqqmbv90KNHZ7Bhy4
         1lU9lplWmiHIXlNUcB+XxkkaA5+vfMegztw/3wY682c/gxHsY6bYR+KNVVy7jS/vcZiS
         5ezHweHfbSrq4jtLwgsCWY32QwD06U5FiinZNbildAn9dLICmm5ceNk0iagQL0VgRPJI
         ByPuJAJgLROZS9aVG/Xp3dt+EwvFm4Hgqqb7KmLayAdRSmLRaN2hvinHofSL7VrHqGNv
         vqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Yt00m+3jBtZPsbqmv+Ufe9mYPSr6+K5EyjxgcJZZpiE=;
        b=g5i86qVC9a3msb/V37SMALcQCCem6jCquRF/JeethR+MIzPSKRbqcvyPiL1Xp2h+ik
         0g89VXg49f/FiOU7bTz9m4UcM6yUIMt3rP1hMgTyjRSbOORQxEHoJVLtdPeloqQ7VMz3
         y+UJXKXWTHjcqJe/zm+928zD1JDdu9xAaYNyEIjitwr7juteqJGqG5SlQASkXWc7O5Ms
         3MvCVLTsZay4n959Pw9kJl7gaJiTxpnOO2PSLnp/T+5ajKVhnIxxUrLTJlZG0eThpqay
         mQKmDSytExp/vqLUy0c8JbWzUP0qYQe9dwOu2+YTL1O84qsWqDcfIhU3urP1RGrZpoKR
         GJAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Mon, 23 Apr 2018 21:38:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
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
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Subject: Re: [PATCH 00/37 v6] PTI support for x86-32
Message-ID: <20180423193825.GA3827@amd>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504711746562?=
X-GMAIL-MSGID: =?utf-8?q?1598567016004479127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> here is the new version of my PTI patches for x86-32 which
> implement last weeks review comments.

Let me test the series:

Applying: x86/entry/32: Leave the kernel via trampoline stack
/data/l/linux-next-32/.git/rebase-apply/patch:80: trailing whitespace.
 /* Load entry stack pointer and allocate frame for eflags/eax */
 warning: 1 line adds whitespace errors.
Applying:  x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
	=09
Might be worth fixing if you'll do another iteration.

I did a quick boot and it works for me.

Tested-by: Pavel Machek <pavel@ucw.cz>

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlreNjEACgkQMOfwapXb+vISvgCeLVpnAlUbWwrOocy3sGGIoFcW
i5UAoItBl3gR3f45LIt6FlzGlSXdVAIG
=7PSV
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
