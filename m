Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELsw9/7AvU7kzOWXcrO0ycK7RGsOkQrceCLHpS44ko4lX2nIV5cEeWkvnMb4qZdvrdldhRUD
ARC-Seal: i=1; a=rsa-sha256; t=1522072762; cv=none;
        d=google.com; s=arc-20160816;
        b=prr1jrQ+ROrVij16NdWkELNEfbOYsNSlZ/cB6db671iLt6ZpGOcIWKgLhEXgqi07Ng
         dFAEGWEz8Spk8OsvHuzxC8EbzK798+aC1Xkt5+cPwnxzOocG/An2OjWFSc6Z4Gn36B9D
         tIR31LpK2fp+jt/7c36Zu78e8dDVkUjKtJTSDGoTnbddG0YjBLNJNui8FyqfHPjBItbi
         o3CamsP/BTlwEkn+5NiwMjC6L4NgcMZv+FFGve7HEZhJSXoLLJLurRM/9eTJMarBxlDv
         JiYgOO7C2Zz06k2V/DN0kiPt6AaRsUhQU3LY1EHEe2RlcTQIn4aavzgsjgOVRL2kPhjz
         0JSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JHNWeIwWG0bZ/c2Ukc1CrQkzV6I/h1NyPK1miJTCTvU=;
        b=nrDHl74uDp0c9qEiFUaZMM8W7zg8Aa9gmBAtHYTLNXsu+ajN8wU1zns+6YuCxT4S71
         RHc3ner1HFkUaWQY8Vq5wAiNs7G+vTlhsy9lUSQjpXUkalKc+bz4qqCnekfaT52DfupY
         MXWsCfgH4oNSQ5wiWEQu4Yu6CLwDSQm8eQYZqiSFFB3GOILF/8UlsTOcETyHg3l0znYh
         y+8+KS5UyMcQdpIu5Ccd1sS+zryeHy3hYUgl1nKAr+5fo8WLfb8HZx+wqydT9UV8eo7e
         lYQI+e4ndR3+sre8lmP6LCKW2V92GuUFvnTbSG0cCKD1R/LPxaadKG1D5+cujpBb45+X
         aggw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Mon, 26 Mar 2018 15:59:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Thierry Reding <treding@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180326135920.GA1450@amd>
References: <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
 <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
 <20180319135418.GL18359@localhost>
 <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1596008968945391433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > No, we need some kind of at least rudimentary gps framework even if we
> > allow for a raw (NMEA) interface for the time being (possibly
> > indefinitely).
>=20
> Ok, that would be fine if we can get that!
>=20
> For a minimal set of API I think something like this (following hci_dev) =
would suffice:
>=20
> struct gps_dev {
> 	...
> 	int (*open)(struct gps_dev *gdev);
> 	int (*close)(struct gps_dev *gdev);
> 	int (*send)(struct gps_dev *gdev, char *data, int length);
> };
>=20
> int gps_register_dev(struct gps_dev *gdev);
> void gps_unregister_dev(struct gps_dev *gdev);
> int gps_recv_nmea_chars(struct gps_dev *gdev, char *data, int length);
>=20
> If that would wrap all creation of some /dev/ttyGPS0 (or however it is ca=
lled),
> it would fit our needs for a driver and user-space for our system.
>=20
> And I would be happy to get rid of creating and registering a /dev/ttyGPS0
> in the w2sg0004 driver.

Sounds like a good start.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq4/LgACgkQMOfwapXb+vL8hgCfS0UWaS1wC9bm/jIlnajYRwgo
ReUAoIYO2jKAA99I3pDDwchvNGTzCbEZ
=IReX
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
