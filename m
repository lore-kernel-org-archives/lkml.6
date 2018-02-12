Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AH8x224Iii6NfY0jvVPrwvYUTMNh9fqhxGRnSMCYzqWFTcRIPXsK1poLP7XelROmX6Z2A59ciKcR
ARC-Seal: i=1; a=rsa-sha256; t=1518449151; cv=none;
        d=google.com; s=arc-20160816;
        b=v9D5Zp2BXI0GqMLmDJptg2qMAoe1RdiRnoCGwUx8RyqSfX4tbYF7RBJHq+ywhLXq41
         bDgZwfD9W1W3pSoA/1+iV2yqrZZzqjK8aLNVZPadPlr9QxijDbK/bQywB7PHr2sP+Nyo
         maaS+ocqZ18yJ4VVQ112AiT/XZSWyoltvndeqYPNSelQDecruwbG9OnnhFw+OdVrk6K5
         xf5mUZnpytL8v8ojHyeefa8nGp8O36uigOOR3/kf9Ovc7zxZSmnrN10xVW9KxARvYmr/
         SZwvAsd6ZSzpATZKJBs3+LxGd+LZmbnG5xOUxnxtS+PJRHyItYEj6bU81MUij4CK9Rqw
         1QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=we9qQ1gveM7bSHn8YvgpUPYEP3v4uwbsLeKDB6n6aQQ=;
        b=x8pjwjEDjgKyVX3w4lY7DAP3SyBOY8l7+NfcJbv4d7x5ete+SeYSWirkCUlJtte/1N
         EyxZn63KyyvgMASRclmqRf6sFmykwe8LhBrhMW7bWpRtXP5uZwEKuSsI7iNIcZBzzrBA
         DOPodPUhQoMUY9p1jWswCImNQObqpjloXLLp6NNG5Vqj+T078g3vYTUdavMollqoVzjm
         CAE9Sa4Jt7mniaN35X19PXoyPE8cLdbhqv929xSlzf6ac5fmksCxnadI5VyVwYUUGjpG
         nxpkemqU4E8wvPPVK3QXZ4eAz5A6SjblIaP0q53Z/Wj+DLGDGPYjWUzh/C3l159Tyii6
         Ps2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Mon, 12 Feb 2018 16:25:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Thierry Reding <treding@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180212152547.GA13962@amd>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1592209337135330084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I'm sorry (and I know this discussion has been going on for a long
> >> time),but this still feels like too much of a hack.
>=20
> Happy new year ... Happy new attempt...
>=20
> Let's restart this discussion and focus on the main roadblock (others are=
 minor
> details which can be sorted out later).
>=20
> If it feels like a hack, the key issue seems to me to be the choice of
> the API to present the GPS data to user space. Right?
>=20
> I see three reasonable options how this presentation can be done:
>=20
> 1. char device
> 2. tty device
> 3. some new gps interface API (similar to network, bluetooth interfaces)
> 4. no driver and use the UART tty directly

> 3. some new gps interface API
> + could become very elegant and general
> - does not exist (AFAIK not even a plan but I am not aware of everything)
> - no user-space daemons and applications exist which use it

Yes, that is what needs to be done. It is very similar problem to
serial mice we used to have long time ago. (And it has pretty much
same solution; exporting NMEA for gpsd, then slowly moving to system
with no gpsd).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqBsfsACgkQMOfwapXb+vIztgCgpEcmQ7dvaYf7kgZRjfe0YBDw
v+gAoMKpp9BRiTQ1XZyg/N2O0lebNF7X
=NWEi
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
