Return-Path: <pali.rohar@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520009681; cv=none;
        d=google.com; s=arc-20160816;
        b=HGSJNuoMZGSoUZqCW/mRLoUUfN5MCes0mg5LCT2iwWKeoK+DkBVN9nITJzKe6scb0w
         lQp0MJaguPi7hUdxeVQTVzK0yyTYGzJct4+shMjmjcqGJe/VZW0Rtoc86SWe/oPXU3X+
         8VAqTVyKUW2qFYFDOmu5Cx2PMx27vXtJa5mkTE3XQkgM6j9OXqtSJZvLj+evKwKBjYa3
         Meus7IgVmDPdrhgbTO6O82vTyDTDYXS5MYudEffLEbEEmx1CbHTqlSkoPJI42wYtBWLy
         bimHrSIG1U2GtZ5pRbdgfyXeAWfSD+tLgH4/RkW8GAzkFGsGR68ncmvn+n/ZgvRH8Zhs
         XFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Boicry2xmJbk0oXpnbLlWRhoUhMBtXQF9UZBSUgFiHw=;
        b=TUQT5WIoRMv/s+4GddfIMlXPwfewtwjZg8K5FnE1ExOgkJH59WsU8MTs8UxCqoHOQH
         y4FE5PTafaSl0Sj9Cji9u+9kUybrObTzoxVWU3rr2YX2YEXxsrqZCZPxqOcO/xsStygZ
         TP1UMHXiNwqbcpczyqQBsYKzcU+/6GP80sTolMUCEuKJqOpDBqYjjMi6nOINwsoqJCmF
         1eym+EJh3kjUi+EYx+O+aTjrlcgXPLETC0EiaXyuNJ8qFkZfmze63bod5kq16LEh+/Tr
         Wl7DG+upvDZ9JsOkyNFRAm1Xpjq/C3/p8fj4JiHDSunJ3ST726eiXCT1f2fzvQyC/ivL
         PMBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JkMIvr44;
       spf=pass (google.com: domain of pali.rohar@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pali.rohar@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JkMIvr44;
       spf=pass (google.com: domain of pali.rohar@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pali.rohar@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvSth0nO27FZPPnFm3s13STFBC23ULqa1DKpu22NuGr3KpYE9/6j18y/nh1dIB3MrbLBRD6rQ==
Date: Fri, 2 Mar 2018 17:54:39 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-omap@vger.kernel.org
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Message-ID: <20180302165439.62xw4slhhupy4vy5@pali>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbba6go523codbpi"
Content-Disposition: inline
In-Reply-To: <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593781038730915565?=
X-GMAIL-MSGID: =?utf-8?q?1593845672031784662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--kbba6go523codbpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 02 March 2018 17:47:52 Merlijn Wajer wrote:
> >> I would expect it to state "b_idle" instead of "(null)".
> >=20
> > Actually, I'd like to see (null) whenever a gadget driver is not loaded,
> > which indicates a gadget is not bound to the udc.
>=20
> Hm... Sounds fine to me. I'm using this mode in combination with the usb
> phy (vbus property) to detect if the phone is detect to a 'dumb' charger
> of a PC, but I can just always have a gadget loaded -- same as before,
> really.

For detection if wallcharger or pc usb charger is connected, there is
isp1704_charger driver. It uses some standard ULPI interface. It reports
current_max and type (DCP - dedicated, CDP or just usb).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--kbba6go523codbpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWpmBzQAKCRCL8Mk9A+RD
UkciAJ9Q8KL6azfkLa9MCs6XjsP48qPTFgCgqhEEsflewq3nkYVu/ILmxF2paLc=
=qUKz
-----END PGP SIGNATURE-----

--kbba6go523codbpi--
