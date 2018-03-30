Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx49AO4wt9PWu3niPIsIFf2L0RNnvV4/WYsnE7/6yM9vd1rbQrSvFAOosNo0ohEAUzUT5uf62
ARC-Seal: i=1; a=rsa-sha256; t=1522396509; cv=none;
        d=google.com; s=arc-20160816;
        b=hlqKDvQfpPsNSWhXLjbOexI4DhOy4bWgp00I80Z/l8OjKuxem+UeJ5bKS1mWjT8ZYV
         qlrDcceFxH9wwVKnTFosztCg/fyNXXkjdqitjip/2kpu/Xd3Z5dMBXoMS2kkSUSB+1M7
         IwVgCjSF+shLvqlHHyIEHo9PVLv0HA2/IGq5njTRPxiOm1XVGV6hMMWGlVlFpwi7xv7A
         1rw+ZpVpmLw7tPufhyqj4RtU/HGZpgyiXXKcyoP07hsy2KpUAviMutd2WN8l7+c0UJit
         3tJ1Y6lQJ2a5XAYFachEaNNFvdidwxh+Zj0JSrfl692uoAKEDhVnG2is3ZOxsjon2Wni
         m4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SqOVL9tkEgTMNeif65Vhv/sS0Gnorhk+pC/m2oy00nA=;
        b=aOOG9V37gPG65akwrwbiJWUkgaDrCV+KVW+/KMSLEgWhI1eOpI6ZXzK7n98OQwJv/8
         d5LFunsX/pb9xwPkSeQeFU2w2gQcG4thoUpUJ+V4eh0xpD7f2OjQZrrQp6AeqqGLNYDb
         eVmX9lTpIK3qmqcITcK/CYDlOkGmbh293mM36K+4mXHX76b0YT/UMGY5aeiDqgRFU6XH
         xPy9t+rEgdHrPKt6q37+KMmyh2uupVfjGVZjWzjg7f+I4xGG1zxzQsaZvkroGrJLe/Lf
         GIp/A1nMMK2yx8GD/26gXk8CDH6CkReH8xt0SFYIKgbxS3AXju2663hwE1RHkW+zByls
         DcRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Fri, 30 Mar 2018 09:55:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
	vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
	fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
	jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
	deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
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
Message-ID: <20180330075508.GA21798@amd>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596348442922549187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Current implementation doesn't randomize address returned by mmap.
> All the entropy ends with choosing mmap_base_addr at the process
> creation. After that mmap build very predictable layout of address
> space. It allows to bypass ASLR in many cases. This patch make
> randomization of address on any mmap call.

How will this interact with people debugging their application, and
getting different behaviours based on memory layout?

strace, strace again, get different results?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq97VwACgkQMOfwapXb+vI6UQCdF4AyQJZJhtFyHLBBqwpvR1q8
v88AnRJDGP+1mNMTwfSngE35HzilPhGr
=dXPW
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
