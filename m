Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4+mZMbrJwB4KiFM3B6Z7TTs9K5dv2MYEhsdqMvm7nW2/2OAihUfnC+dtjtxvelQiMajnViD
ARC-Seal: i=1; a=rsa-sha256; t=1524602312; cv=none;
        d=google.com; s=arc-20160816;
        b=Fra0S+4fSlPYogdTYR7LdtxzDN03wF/wh9QjmQoPD2cmodKQ/Vy8R5Ra2bH80ouxLg
         xTSr3QWiYR4og5GV4XfKWHi2f6QT5A85b6nnxY2slMZTrbEas7TLskeNmRDbVgDEkzMg
         THGnJMBcVdreQiYZrDiig1/MtFOJgTF97XubKsbkWoK1QYqRvwbIpE1qgOdyioIpoaug
         eQ8+VnwdyAA75uJcvDMJNPYlqYeQ+zSvsQEkFTMQxQCtdZy3jp/0KW0WDq0T0T68RMiY
         aBBk/Ah0kQ0LzRvBspzwPMVnwotzBGfgGev3c3HUzddzSW6FG+kEgxXeQljO694nX51d
         KX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GrH8ntdF9PXS7eB7BY7M17yVFNqk82OejELAkk883KM=;
        b=CpUlsCmRbwycL5YAYUPXQA15B9Wl8iMfPL3VpeR2aMVS+2gVVkwb2viH0AM2MkSWfS
         p8j0bBhN0cxzgGPn9m7A2Wdla3nU9Drlv1yKaHTN8duSoWS6/BcXxdD0TNWB68Srk3JT
         Qewt4DqkwgafZMR/IJ3bGSWMvmnH1pskQjS/E9Ndn9fppOUIueF88x7PJNckP2rYON6n
         CeVI5llvfoFoIqhtnIannEL3AVMWaKQHmCwuaw587I5Spp8sUrYgkh1rYqD1Y0k4R0zc
         Z6mYphcmYR3VuVWjtKk7oFySvbbGN93Ey4hcKlcEEKwuc8MZf/MuqkjnELoKUWVD7P2C
         l0/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Tue, 24 Apr 2018 22:38:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180424203832.GA22207@amd>
References: <20180424163458.11947-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598661394861003207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> As proof-of-concept I have implemented drivers for receivers based on
> two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
> hardware these have so far only been tested using mockup devices and a
> USB-serial-based GPS device (using out-of-tree code). [ Let me know if
> you've got any evalutation kits to spare. ]

Do you have easy access to Nokia N900 or Motorola Droid 4? They should
be reasonably cheap, and each provides unique challenge.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrflcgACgkQMOfwapXb+vJ3cgCfbLyAqcH7MZWzSRNjl60B+8Sr
gs8AoKKk0jBLpBuVDa8RWuZQQbJEj87c
=qp9z
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
