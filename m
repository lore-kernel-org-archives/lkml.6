Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4+jWSXeGmSPzYkSFLChd6X2DOt4P6dnZMY95i2nkzs4wAUHVmnUiwil/tehcoAj/Yrgyfzc
ARC-Seal: i=1; a=rsa-sha256; t=1522403856; cv=none;
        d=google.com; s=arc-20160816;
        b=zZiuxs7y9nR8mwCw/Blq8GkTsGKod01pl9WDP5mLQoCBphAnf23xoek5dtfmkCWKJN
         /OPLzneeTs8vLF7uHxpaSoctmd04zbGMW5s7GQ19qTQvTDP69N+mbAexIHnIDi+aMW0r
         9uoqwlna5I/oolZ0qaRNE1t4rPDTNZgBZ8FKvqrpl9BWwNXjCgqfGXI3L8m4rGODkx/h
         blsz3aElP/onw0sken9OE1dO0h/bgx3kOLUglWQ64z05Q+P5Eel4Z+YwvQc3EvL2IskL
         2JvhcGyznCZX+3V05fGQNgYrJbHMawdlcXzCgjNkF7uDtY41YHy0Q+JK670lFTIomtDm
         9EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2AOsLG2xIA0nf+pcMDxD+Jpwl2nTQj0FzJkzfrJ6zaU=;
        b=fhg2JferVsbBNw7ITHURJEGfLZ00jDvU++ZD9SsCCe3clI3mjFaVWb5M834TuXYj0n
         AUVFztuG93SejT1z4dRvu9+3CZtUvpsog1FoUZE6bMKImbkiWTD3eKMKq9m/l+7xQj8M
         FAx8eiKk2ZVev0S/5q7kstvr8TAoGsB/L7m4kSmbA3tYIVBDP+qH+krzVky1VYz7Rgaf
         ObxKxLVUwcdMkcC9nsI1a4TV6vtV8MNxsBWdUro/LyDpBsTq84TQHXz80Ie7f48Ve40+
         csKJHr4o+oHEPT4AcpN6JxsgG88kfZeJgXtCrLXFJr0dzMxVmnwD2+oim/NfplcdK+6v
         fG6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 30 Mar 2018 11:57:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
	vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
	fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
	jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
	Michal Hocko <mhocko@suse.com>, hughd@google.com,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	akpm@linux-foundation.org, steve.capper@arm.com,
	punit.agrawal@arm.com, paul.burton@mips.com,
	aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
	keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
	nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
	dan.j.williams@intel.com, jack@suse.cz,
	ross.zwisler@linux.intel.com, jglisse@redhat.com,
	willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180330095735.GA15641@amd>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd>
 <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596356146157343966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 12:07:58, Ilya Smith wrote:
> Hi
>=20
> > On 30 Mar 2018, at 10:55, Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> > Hi!
> >=20
> >> Current implementation doesn't randomize address returned by mmap.
> >> All the entropy ends with choosing mmap_base_addr at the process
> >> creation. After that mmap build very predictable layout of address
> >> space. It allows to bypass ASLR in many cases. This patch make
> >> randomization of address on any mmap call.
> >=20
> > How will this interact with people debugging their application, and
> > getting different behaviours based on memory layout?
> >=20
> > strace, strace again, get different results?
> >=20
>=20
> Honestly I=E2=80=99m confused about your question. If the only one way fo=
r debugging=20
> application is to use predictable mmap behaviour, then something went wro=
ng in=20
> this live and we should stop using computers at all.

I'm not saying "only way". I'm saying one way, and you are breaking
that. There's advanced stuff like debuggers going "back in time".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+Cg8ACgkQMOfwapXb+vJu0QCdEsEH77ETyX2HVZNSmFfJe/v+
DCwAnjMGWij1bTYek7//IiDd4px1ZWUT
=qmNi
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
