Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524480032; cv=none;
        d=google.com; s=arc-20160816;
        b=qWDWV3LiAfzLF1DsaSljOqh3Wmsh0C5ZI08jYd7vsZD7eVnxIb2uHL/uM6dTd6MMB8
         ucAekuCuGpBTK2H6igVW8SRRb3DbKv+0V7fR4nesIcgtJ/Jki6g+kwL7Jla783ewkuNo
         dltOzFSLzdVHupA0JPGqVC1+ezNK7QJdYvstJ1cYJMz8c7Md2Tb0KH6URB2EsE1Wkaqm
         JnKPTBL/bPKz33qiTwoGWB0NBsxRivRuCwy8K2GVKITyKdn7Bd14dZ8fC8vH0hbpeQZn
         WDg4p7FFNkl6wlmZMRWGgzy2FcN5dAHbc09mULZ667CNcnRuL7cVzai7+mFPBMOEyZ+1
         hCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vpN8Nm3GtJwvmeWJDzM/TVsHWZtGLe7+9lS/4nBeRYw=;
        b=iF3uoEzYmYsC6EKZ0fErq8jPNuPZiU/stx5tdfhobVnIU4dTSCLrHk3mR9kQ3JK+FW
         O/yqCgpoqBD6VUGhea9GcyrsRoDmhIbZVNB7J+07wboLt06GqslzqLsBGcaLSK6ecq3E
         V/osd5b/SWh2KpCDraiUq+BnJt4u1hrhNUxecG21V9quIHHt1WCCzfJFHaIGAKti66fe
         mn5Rp8WKBM4UXLIGjwkeKsBwn9ruZivzBjDSjMlVgGrMxe5ux9vdB0I2ljrO8VpF1ogt
         6LV8DvgI1LzB44cF2LTBNrioFUa86zUkfMDtepqaE/1x7pMx8qK7v1/iR2bdZjS+9BHJ
         3TPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRtNKoG2;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRtNKoG2;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48fiYMOmuzEoLXCljKUZdT2qjxCAC/SVcHVxRO97GCAfVQhULvQuHnbklKV3h+F9uqYErGGyQ==
Date: Mon, 23 Apr 2018 00:40:29 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>,
	Tomasz Kramkowsk <tk@the-tk.com>
Subject: Re: [PATCH v2 1/4] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180423104029.57dnqhyiljftyxyk@gmail.com>
References: <20180324112732.29424-1-joeypabalinas@gmail.com>
 <20180324112732.29424-2-joeypabalinas@gmail.com>
 <20180423085131.GA3894@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jbwzk2mwn5w3qzf5"
Content-Disposition: inline
In-Reply-To: <20180423085131.GA3894@kroah.com>
User-Agent: NeoMutt/20180323-62-378db9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595818229750287449?=
X-GMAIL-MSGID: =?utf-8?q?1598533174678614949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jbwzk2mwn5w3qzf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 10:51:31AM +0200, Greg Kroah-Hartman wrote:
> Something is really odd here, look at what is in your changelog above :(
>=20
> Same for all of these patches.  Can you please fix up and resend?

Ah whoops, will do.

--=20
Cheers,
Joey Pabalinas

--jbwzk2mwn5w3qzf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrduB0ACgkQruvLfWhy
VBmIJg/+MyeudjWDxwdKffRPLPjl5VluYzVLQAdcOYmEsyvS7WUXB0eprapA1I1A
CXWmzGQ/7v+cwxv8b2G+ByFkf/VHorLyprCH6amBaVk/xQefYB5ug2bZMrPmBKuv
V9rn95bni5ky39E9238yTsxHX2+HTWiQE1laMijvhDBy7CTKmbO5nD0VCWpyE5wz
An8fgmuMpZglLNoi8Olpu1lrHGz/7lPBqfgD+ceqSo3hDH/w/ajZguyN+yTf0aGX
miAFTqRX3i7/eBJFetFLV639D9KIwslx0VULCKT2VAxiDTYhX9aF+shZBl8lz/FW
vvnd8GEtQ5l6fg4S7MLuSzeqna3/KskV4Up9NQ/mloWJYKwnuypiJ0N1yDs9ZYLv
jxab/okXFk0ba9gIcj1b/oS7pg+BbiFebbyX0YURj1vtaLrjuwSQj7ley1F+1Pwz
sjssl8yZND99bzyq2hiT8a1yoOEXpBuJGtdutzw+fQXbZkfDDM3jf/hsd/PzGD+F
Sh3jLzdGJmRbWsroEGtTgdFDKOuym5CEn17PiGXhXHFOKfW1WoBbI4sl/p/B9Bmz
ZbtaDRqJoaS/sk/uuhHflwbCxkgCoPuufulrmS8g2ZXwwKWNmVbsrOFVOMrUkBRe
WbMa9vYvlV2Z9cLqGDfuvUHunz8lmECCmfJLPHgYUMvgA/iRsng=
=2BaY
-----END PGP SIGNATURE-----

--jbwzk2mwn5w3qzf5--
