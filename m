Return-Path: <quentin.schulz@bootlin.com>
X-Google-Smtp-Source: AG47ELvnLlj66W1a+GGrSHXemMTHRXrXyO1W5LonRfyP5CYYhtynFZN1DMGZ1GLSi/+VFpD7axs/
ARC-Seal: i=1; a=rsa-sha256; t=1521789929; cv=none;
        d=google.com; s=arc-20160816;
        b=SNI8lIVcP0MrSKxvtfgDP7GXX4vp1UfZH9Rp8xRprtq86cgOAK1Se+SNSwnqPhxWiV
         YaBiba18UirXlVeEeDwT42Dpg6Njor/SFVZWT+KwzG+D8VnaZWdQ0C4yuLtkmYpve8Oy
         gj9YcHaH1T3w63Yb1yhEuoJaleQoiaI3H5jM08S4jO2b/trduIEX9Zomafmg8HBKCX/c
         5g7xcKX9YIPHxJ413WRGw7ljtA6JrnfDbEKOQPf2oda4mNt95gKUWZtcLiG/DHjXK4Em
         eDEGP07gtTFagBTEUNPun2aQK6ebU5kqoPWowRemM8/NkeMVLCSExv+oOdHbRymtxTBG
         HbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=yjXYuoYuxML0YLInP2uKkSh/Nx0+RHQHAiZE2SQsEQM=;
        b=qj3mWhIMevXS4X9HhZamM6DDzPPw0VV6avFTX3b4xm3RMjKS5wwbe3n+ZIUjGJez3A
         SY8QvEP3Lw8AH8ATlIW/g4gf7MnQ/kfly8bdhZeVJ987yrl2l4Nc2HX2e/Xo1+9C1Ls+
         rY5FhkGeYai1xOEEKUeNGMfacvJePvCNSpVS35/X2i22YZcYPEWqqj+3tvtN/xDhM4tN
         wl5z6eWtBiLYu3amSdG6t7bySnV87l/PM5h2ef5nXaZ/hXS3lEdehc0QH/FwG4bPsbhG
         4mcoSzhzZ/Z1nUVmjv1ioji+MRsZe2i60iJkWTcR7G8Yqt7oaWpwICbziFSdNKi3pjkH
         iM0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.schulz@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=quentin.schulz@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.schulz@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=quentin.schulz@bootlin.com
Date: Fri, 23 Mar 2018 08:25:26 +0100
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Baolin Wang <baolin.wang@linaro.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	driverdevel <devel@driverdev.osuosl.org>,
	Icenowy Zheng <icenowy@aosc.xyz>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Message-ID: <20180323072526.xvqamolxbmxk2de7@qschulz>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-3-quentin.schulz@free-electrons.com>
 <4015f7df-36ca-c762-5b9a-94a270f65475@redhat.com>
 <CAPDyKFpePxfAc20NCO7xvbGca8m=Bymc=5KBYFF570rnACViQA@mail.gmail.com>
 <20180208145952.qlq4sxohqd3s7m7o@qschulz>
 <CAPDyKFrbRVgOFRKpO5TdwHO-XQ035exrUt_bgM=BaxnEPmCvrw@mail.gmail.com>
 <20180209080541.edgjbhjo542vq3h6@qschulz>
 <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ycqgfhmspyyj7oby"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1573543183974033537?=
X-GMAIL-MSGID: =?utf-8?q?1595712397328402673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ycqgfhmspyyj7oby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Uffe,

On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
> [...]
>=20
> >> > I'd like to know if any progress has been made on that problem (I may
> >> > have missed patches).
> >> > Had you had the time to look at the issue?
> >>
> >> I have looked at the issue, but not manage to cook some patches for it.
> >>
> >> However, it's on my top of my TODO list for mmc. No promises, but
> >> perhaps and hopefully I manage to get something posted during the
> >> coming release cycle.
> >>
> >
> > Cool! If you ever need some testing, I'd be glad to test your patches
> > (even if they are in a draft/RFC state).
> >
> > Also, when you send patches, I'd appreciate being Cc'ed so that I can
> > put my Tested-by :) Thanks!
>=20
> Absolutely! I appreciate it.
>=20

Any news? Can I help in any way?

Best regards,
Quentin

--ycqgfhmspyyj7oby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJatKvkAAoJEIS4mnU+4PGj5DwQAKuqH2p7Gp5Fd2MlQ3KJQ3x+
JaA6zJp8dDiiK4Y6AvHzNwz3LsRyyXHKhZBStYUTgGAnkxMa0rdI3pV/gKkvcH2+
89p6BmUO9IL/LgVb7beHHffS490A41hBege0ok5zkBHDEJJU1mUsisKJMM7dQ6JI
aZxEomoOYiAECoIRPByGjo5kW02VJnE95SGsQRH9kvHsN5v5r0gxv6LUbOyIMeVT
7FmOTdv+mIId1+RyJv5PxdidMWCDjRHFeQMBmKBKDN0ejW0udU2EnyuI1YVRMmmm
MoJeoif1D5whNOV3pO2/+2L3VXdJDL4tbKbNG+F86DDirPCBizCftXJonwu0eweb
TshgflQuukPrYnfh3/D4za6mnjxJmc7raxRvQfjlGgcDSqIuwNZp1dS47GtwjZZS
ZLZb1l9PzO1fhmTYP4vzNb8u+OJ236o6JR3Wu0TDN4ZMRFT+s5g8OHM3rjIHbxzs
66jJRgdYItLfd/w1C/XN2LAKX2FxLPnplshh7U4rTsqtuqSj57sXiwCYWMBlJcUo
jQseQsb6yKvH8taJlJh5GLsgcEflq8S3lsV16wrSKVETq58aYOKpchCR3Rw3sw71
5HZg6n8H7dFN1hVGluXShmWzsYlMMnXcSh3qY5+aipsIAKZpR1oBpW0xSymCYr1p
S/uuwylI9lkcvb7ihKJa
=gxA1
-----END PGP SIGNATURE-----

--ycqgfhmspyyj7oby--
