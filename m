Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELvskjfrT8i9ljQRScFKDJLqgrhBLzQTMVWJiSP25kDOd+vnSXglbaCeHUx33K6URlFvaHun
ARC-Seal: i=1; a=rsa-sha256; t=1520460685; cv=none;
        d=google.com; s=arc-20160816;
        b=glKqyjaR/KC9HQZPZbnnLvTnt6lHtO7ZBmkUNlDiOacwa8+O50Xz96AxMK5Cz9GCQA
         EqsbwALCSMqyeyDObO55DzCSVhzl55X4a6dtMzYIHfdaSgaqesXxBoYN8Lqoms0Duiwn
         6uqjVDd0v1SAanUMygosOR7RL2zI6msoDWw0DHYXlHSoO3kqNmXhEnD0L0wZa8Cz9GTE
         nUH7l0i234W3M5z8G2Zetl1oHowQEpN684cojoir5NPBjZ9SfElfneVC2Q7LrlbGe2hg
         +l2qC0+BJHK6c8GuqpNJOENKx1p8oV4Jp5rf53njZsOT3ak3xgCfcF/5gBrDrxp6z1lX
         EREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zKVabeR3rSYGVCkoc+ZM/VIgpNBPulLxSLY9zT+Q57o=;
        b=OKfxAN8CCoPckZfoTx8xGOO7DJRn6lHbqlJa6mRZdbdW732/DUf1atypXqrHCIWJj0
         Zi0iOWopXjHj/aLUw6oi3hWt4leWO8trEFQyi/QPuj8WyX2RxDEwbhxNBy7quwKZrkKA
         6XRpzRrVIuyQ4gq2hjyxYh5aSOGIyGYFvfD6wfHvS6kFTBtnWTiEgTE+UDZoPn8KaFeK
         A7aOipmPSPSgFl3UaoPEty6itPlDjR1rNmUijaxovvN1Q1ItXCuYH//tz5/fSbxNYyFK
         U1WMwdaytkufkH1Mj9UIFZzvO+8RJlDv3P6DygyHDc+M+rwSXR75zhOhpRWXAoAYKIlk
         h7aA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Wed, 7 Mar 2018 23:11:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Message-ID: <20180307221124.GD10438@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594318583775658529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Are these SoCs x86-based?
>=20
> Yes, these are ARM SoCs. Please see Andrew's answer as well.

Understood, thanks.

> >>+	Read sampling point selection. The whole period of a bit time will be
> >>+	divided into 16 time frames. This value will determine which time fra=
me
> >>+	this controller will sample PECI signal for data read back. Usually in
> >>+	the middle of a bit time is the best.
> >
> >English? "This value will determine when this controller"?
> >
>=20
> Could I change it like below?:
>=20
> "This value will determine in which time frame this controller samples PE=
CI
> signal for data read back"

I guess... I'm not native speaker, I guess this could be improved some
more.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqgY4wACgkQMOfwapXb+vKkpwCgxIl38neoJCtEDSh34sHCjHMb
QxUAnRhNCAIzVU8cgKZ4g2D+qFLjBZM8
=gl0E
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
