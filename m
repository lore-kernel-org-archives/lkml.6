Return-Path: <kernel-hardening-return-13076-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqJJmJZ/JDHqA2/5rxhcc5Yi24mOgM4Twqx2WQQ6LHgsa5NzjC3MG0jwY+Y62LRjWdWZKLE
ARC-Seal: i=1; a=rsa-sha256; t=1524387621; cv=none;
        d=google.com; s=arc-20160816;
        b=VvDRzKFtFBC6rJE3uGPbCNfptK6O2Sk/kN+wBeKv/yL7PeIbteqtnnYqN4H/Ml/IZC
         CnjCPJOf5Xk4n//XCkYYf0WUaAAhsYZscfPlJY7qIzKjZNW+82lxdQosNkwuH8YuEV4X
         g1hqO9lhUvXxc+dkbDl3Rpzua8svGCFSALTTNe8uQF2xqZOYD5wUYu914/HP61izpZF9
         sJWw1uM12O37zPPm+sWcZi62rHP6FTRxO3zoIubGMxoiheEZCg0inYADP0Z7nTnpyVVO
         jysQcckmolBmz9vwURktCeq752T3COgqJ+YOJddGhN3hitLM3fMFg+yKkv+zcQ7I+lEM
         /3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=DsaSezCJt8robO3CU00oBCrpg2w0zaJ+QxrrMhLK6pM=;
        b=LD5M1zC6UxfYQXOtWTNAVamr5udFLE8BDvG23V8nQt+XmLKaehpccOvlghOnrEzi8P
         PaTnxAd+QGjb4vHWpPEWfo8ANOMXY+rwyCgnkUtm0czxHxysZDZXheegA05sBQMR06iJ
         16NMKMXnCHU6CAX0x18b95mdp9kxwXZQAEHaN+m72y7hTmT+OJ5awfSSqqN9gt5na1Bo
         6XqLSMgE8TnFzgp389tdCNZ2kXXpmBIvQdRw/cjM6ewF1rT7d2yiKdkf5JL18G/+ORBs
         y7yBzzbL7tl4acnB+D4v5WrudB0ClYTRgAnN+nV4x/0t6v9whjjKKVk6t6lBmq5Ihgnc
         DADw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13076-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13076-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13076-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13076-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 22 Apr 2018 11:00:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, cdall@kernel.org, drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
	ramana.radhakrishnan@arm.com, suzuki.poulose@arm.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	awallis@codeaurora.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCHv3 11/11] arm64: docs: document pointer authentication
Message-ID: <20180422090003.GA24344@amd>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-12-mark.rutland@arm.com>
 <20180422080520.GC17875@amd>
 <86h8o3r5jy.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <86h8o3r5jy.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019791270913018?=
X-GMAIL-MSGID: =?utf-8?q?1598436273940951109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-04-22 09:47:29, Marc Zyngier wrote:
> On Sun, 22 Apr 2018 09:05:21 +0100,
> Pavel Machek wrote:
> >=20
> > Hi!
> >=20
> > > @@ -205,6 +205,14 @@ Before jumping into the kernel, the following co=
nditions must be met:
> > >      ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
> > >    - The DT or ACPI tables must describe a GICv2 interrupt controller.
> > > =20
> > > +  For CPUs with pointer authentication functionality:
> > > +  - If EL3 is present:
> > > +    SCR_EL3.APK (bit 16) must be initialised to 0b1
> > > +    SCR_EL3.API (bit 17) must be initialised to 0b1
> > > +  - If the kernel is entered at EL1:
> > > +    HCR_EL2.APK (bit 40) must be initialised to 0b1
> > > +    HCR_EL2.API (bit 41) must be initialised to 0b1
> > > +
> >=20
> > 0b1 is quite confusing way to write 1.
>=20
> Do you find 0x1 equally confusing?

It is slightly better. Still I'd not use it for describing single bit.

> 0bx is a pretty common way of describing bit-fields of a hardware
> register. It is also consistent with the rest of this document.

=2E..and inconsistent with rest of the world :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcTxMACgkQMOfwapXb+vKI0ACeMo1/1nh61yFTOI/1mDSHcvzC
YrMAoIhqWJC2fBZtLjTJysk3kqkTVZC/
=h4Dt
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
