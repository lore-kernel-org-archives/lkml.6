Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+zcAzRo4WNZucktILxtnw6ZeD0K4lgjvEAqIeF0JPcuyvN/9A98ETOUg2H8BV8cPtT5iX4
ARC-Seal: i=1; a=rsa-sha256; t=1524650095; cv=none;
        d=google.com; s=arc-20160816;
        b=LCixsPq784j4hWVz1MccdJljPjJ4EH1bEmOHlmeNFMfJKf9vKIlFzWBKcTZfpYJNlX
         NsnlB+OyMGBYl7K1m6zQpZhyHDXz68Pl2LTKe+lVtVRKDPZpu3wSF8B7z4OfK7gxWosU
         FYsJD1aghC7TQ+mh07A3npVoY3bw5Qh8H6wEB5zIzN73FRRHWnrew6QvfnTUtMy43lf9
         vSZIINpJKL0qAWB1KXXniLzdxX4Ml9rBBkwNh0EcI73D0SwoVQtp+ys9WvlYtSTaqSkp
         X1jtJtf8JYwUTrQ06ZCHiBpFBeQDPXXzHGeNLHMbyJBczya/5jr8ATJ4M7aqpCx4dlaf
         80EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=FNxlc3rJi80NTDilrGhdynwsYAy5sEnR+GWpMCJP2Rc=;
        b=GolQGGNq8xh3qHghkb2nQ30jTKDtWP11lvJn4PlWQ42ydytpPncj506gCymmTp3/ar
         ILnr0LvMS0b+qmnvR+qu6xiUZcQZUDmEQra3SSoBaSgQAOpq+the17XfY/aZFTmyldI2
         nuO3yI85cgl/g/guJPOD9bJXETNMe6+xgm0HtTyiniNetUj9a/z54H/0VL1vG1r4UTRZ
         IJHE0qKSeCdEeQo+tfM4XjVHL0q9FMfvw/IbaoY5A7xMuaz4BRNwMPio0IEEEOg6w0Z1
         m/XSIBvhKN3kQxtj5E5OxKY9uADdzVRD6z22nrplSsjmJwHW6DpesnYho+lbcoCZidxd
         2t7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="asc'?scan'208";a="194242638"
From: Felipe Balbi <balbi@kernel.org>
To: Romain Izard <romain.izard.pro@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH 1/3] usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
In-Reply-To: <20180416093405.16612-2-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com> <20180416093405.16612-2-romain.izard.pro@gmail.com>
Date: Wed, 25 Apr 2018 12:53:43 +0300
Message-ID: <87wowvhas8.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894874115790012?=
X-GMAIL-MSGID: =?utf-8?q?1598711498625106683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Romain Izard <romain.izard.pro@gmail.com> writes:

> When converting to GPIO descriptors, gpiod_get_value automatically
> handles the line inversion flags from the device tree.
>
> Do not invert the line twice.
>
> Fixes: 3df034081021fa4b6967ce3364bc7d867ec1c870

your fixes line is incorrect. Please fix and resend. While at that,
please collect Acked-bys and Tested-bys, etc.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlrgUCcACgkQzL64meEa
mQbMMBAAqtdZExCOWqbYhzqYKgstGZ78Y0QUrYR8NpVzppdNwksfLIJZO8pavu2q
61yKKsaCI1MwEYEYvq6LAzzxS/OYVHUJURe3gIz/WuzR+5Va5+9NHg7iokBRb0jz
3xPdRNdDUlkFQNdSyt2cUcor6+8RdC+9dPDCQ/aI7FijMLAuMr9XX2XpemlJOe9F
xrWioG+4uQGXvz5vTFoe7nXAUEtdccAeswhu0pBxuFkGivdR/vPnM2kkP699LMtk
/YFsS/YrCiTnqfz9aw9AMoRwL3WchdDMUKlD5XpZ1fJm4lrrFWUmWs6DYTP88b/v
9tlip/lZmZABH5sBRrsbYHuOyFO0t5G4sJLKE0MaWvBaVuGzA1ZIR6aLU7cF6VAm
iCQTVXZ4cTG32o+l2mbj/hF38E3z485EGaz8BjQE+N5JcliepkLjpSKa0JBo8sb/
9wYyz3O/YDKOYpIQ0A48s13eEEFz3+thkgdcosn83X6r7PYRvkBfAsALp9O8MZNZ
8OpahU+KFNce+ZD4D+KAeVCntN9i0kTc8Rdop56eTS2igBS7bXiIa+fPD5w3rcb4
UP+wzYHdxrxUSlZrMiE9V84XmwqoWI3O67QkbQrIhv7j1FFMfqP5aLP0D9kKd6Mh
ANesfUpsBid+Q8+mMBT72viOEPDyfoPzU1gbgq87M022L6BWYWE=
=d9TL
-----END PGP SIGNATURE-----
--=-=-=--
