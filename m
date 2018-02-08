Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x227RK+RDJh8hfKLtwI8spYxSSqfJ0isQocvyejl9hMt31vrhN7uag8qCeMqiPAEJHRdtujmW
ARC-Seal: i=1; a=rsa-sha256; t=1518079614; cv=none;
        d=google.com; s=arc-20160816;
        b=WdtTIAnUTf5HyL+To8k5DHa+taFuThgMqofGHXnNQCaWL7h1nPCTyYS0yPbS10uJUJ
         lNzgpOVw4BZyadtiCp+kDoD+z1/ugG9c6OAW0geEK9k7gP6UI8+iQ05G61eO/xZeOqR6
         B241cmsOy7bH5RdIySU0CY6k4LsbYVwa4djOaAo8o6N6YnDeXkcV6AzLtmjA9w8GO2J5
         4JAk0jl1Y8R8zbJ9npEXWCzKwL7Yl/JvpMgCDGhLNnLM+cBWJ58X4mtT//pl5EbyXfdj
         SA7d436RRqwHDdcVPgSF/GH520kwIGnoy8cipOkBMUdnEcKn/MvsmkSNoxjgAMzXt40c
         h+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=z9eEjHmab22qnwR+UpqirH4bGGUYtWvPNATZAsKpSU4=;
        b=Jayk32HAhDBXpLH/8TCvH+lv796ZyStmWJPJlH2pGObrSUHbqGAxPccMuMWCFlS+RO
         NHAfROilja0t+lVbGrvAH+PIVRnujlO4iF7N6BM3gkZ5HXLZUL+QT9aWGA86HJvZCp5z
         lCJEK+kBdEA4vUsZfY0leBOryQKf/e6DgQN6wXRQTT1ppHDp2GFLim0qv+0Nhm2/f8hU
         VK6pFhJvkgcx/hgfKm9OQhJwUGPMEWEc5qXU3Pdk7kChmgA9J8aIkakkIq7r3agN4RFw
         kqKeWe4oZbLTBT01V8GodLvYKRwmwvXZ0SOwFUGP4LLQXfZcKX/mTpFsfP0KsPcR2xA3
         xlKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 8 Feb 2018 09:46:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	Haim Cohen <haim.cohen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
	Jim Mattson <jmattson@google.com>, Kan Liang <Kan.liang@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Len Brown <len.brown@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Piotr Luc <piotr.luc@intel.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sean Christopherson <sean.j.christopherson@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v6 00/11] Intel SGX Driver
Message-ID: <20180208084653.GA4595@amd>
References: <20171125193132.24321-1-jarkko.sakkinen@linux.intel.com>
 <CALXu0Uf6qOg4-4aEfepD9hxXsbUtayndNC-nWc_Ymc5psCdEwQ@mail.gmail.com>
 <20180109142730.ndhxmw6p22kae5fv@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20180109142730.ndhxmw6p22kae5fv@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585067671616283380?=
X-GMAIL-MSGID: =?utf-8?q?1591821849331026859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-09 16:27:30, Jarkko Sakkinen wrote:
> On Thu, Jan 04, 2018 at 03:17:24PM +0100, Cedric Blancher wrote:
> > So how does this protect against the MELTDOWN attack (CVE-2017-5754)
> > and the MELTATOMBOMBA4 worm which uses this exploit?
> >=20
> > Ced
>=20
> Everything going out of L1 gets encrypted. This is done to defend
> against peripheral like adversaries and should work also against
> meltdown.

Yeah, but useless against spectre and ability to introduce bit flips
means this is generally useless...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp8Dn0ACgkQMOfwapXb+vIc5wCggjj5Yqpg/20rvxoXsoWVBGhD
Hm8AnRmP5lbu8SNf/Qm+wtDdkd+haUfn
=INFf
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
