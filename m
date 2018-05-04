Return-Path: <sre@kernel.org>
X-Google-Smtp-Source: AB8JxZqj4YvgUIov6eajqvs1Q41eiE1ukXbYpCoJKiMJP8QAQ8SaCi8ilr3cGOIt6se6mx+G4WWF
ARC-Seal: i=1; a=rsa-sha256; t=1525441083; cv=none;
        d=google.com; s=arc-20160816;
        b=iDzcRG/slTZzzvHU83eFt79z5AfG6sYLLVgvYu7Ial3Dgy20ncsqobr7USevvO8xAc
         seVGLU6MyyMBgrOF2JHf+pA9sukCLZIU/nI8BGFgfxmaQZtjHijIS6DcXpwKqyFMcFlT
         wqG4gEP6Xk9cpDnC8u6G64yRB1HuQe9p8L0zHlYZL77tBKIp0z1Y8nrGz2tuyRy08KHx
         meAuClTJs7u7kW+0foWqVllLQGxXKnQjN5mcnCc1Fbo7aKt5Wv4h6o4bNsa54cfYopF7
         PVy9+mldgq67+ma5nV/QBBXWX83IMhoXW1OxVI2tzbhevKy8dpqp/o9TFmc8yX2C/+a6
         UfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rTL3CevQ7xXae47VlwBMVYWXRjJ90rqwIA+mmSGggu4=;
        b=Wp/xIFGNpfpJ8uH6560H8s8lsfS+Vk4D9w1+5lk9dWrWMjw8/G83K9aZeWaDa7ND1t
         kEQ29TTPlBmPiDeeJ8NUIgLZy/b5R2NsVCb23Dv1pMc0pr86eQYWf8xFuij6pv29wvuW
         iQxcYjxViicddTZOzi4RF1agy9ohgBzA6RSmnIC700epoC/+jatNDo5gNl5PKcWFGtwB
         NWXqcSZ3ck4AZrXdD64cWCTMMI2WjnaayiM4HRrGLnD6KlwtSgc7WCiPZO7EgK1HXr84
         PbsUa3G6p8oOpwPMmC3TplMgoy8lU2oqro/KPKHLC9ra/P1qssM8xu3w64hNiiAxntd0
         jujA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dzUZu6eo;
       spf=pass (google.com: domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dzUZu6eo;
       spf=pass (google.com: domain of sre@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sre@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 15:37:59 +0200
From: Sebastian Reichel <sre@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180504133759.xauwewrqevsbhjyr@earth.universe>
References: <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b3dmbfubuz4ltplf"
Content-Disposition: inline
In-Reply-To: <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599540909414988571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--b3dmbfubuz4ltplf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 04, 2018 at 02:04:15PM +0200, H. Nikolaus Schaller wrote:
> > Am 04.05.2018 um 13:42 schrieb Sebastian Reichel <sre@kernel.org>:
> >> I think it does not need much more (if at all) than a gpio controller =
on
> >> the OMAP3 chip (I think the clocks are active anyways for use by the o=
ther
> >> UARTs).
> >>=20
> >> We had proposed years ago to reprogram the UART RX pin by pinmux-states
> >> into an interrupt gpio but that was rejected because it was not general
> >> enough and ugly in the device tree (an rx-gpios record where the rx-li=
ne
> >> is already connected to the UART-rx).
> >>=20
> >> Then we did experiment with tapping the UART driver and finally the
> >> serdev API was developed to solve this problem. Hence we use it now th=
is
> >> way.
> >=20
> > Having any UART active on OMAP results in the SoC not entering
> > idle/off wasting energy. For normal (i.e. not connected to a peripheral)
> > TTYs you can enable runtime autosuspend and configure the RX pin as
> > wakeup interrupt. This will wakeup the TTY on incoming traffic, but you
> > will lose the first few characters (since the serial device needs some
> > time to wakeup). This is for example supported by the N900 uart3
> > (debug uart):
> >=20
> > $ grep -A4 "&uart3 {" arch/arm/boot/dts/omap3-n900.dts=20
> > &uart3 {
> > 	interrupts-extended =3D <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
> > 	pinctrl-names =3D "default";
> > 	pinctrl-0 =3D <&uart3_pins>;
> > };
> >=20
> > To get it working, you also need to enable autosuspend for the tty
> > in userspace (echo 3000 /sys/class/tty/ttyS2/device/power/autosuspend_d=
elay_ms).
> > This is not enabled by default due to the character loss characteristic
> > during wakeup.
> >=20
> > Having said all of this, serdev does not yet support runtime PM (at
> > all). Tony is currently looking into it. Fortunately serdev allows
> > us to enable runtime PM by default (once implemented), since we know
> > the remote side and can (hopefully) avoid losing characters (i.e.
> > with sideband wakeup gpios).
>=20
> thanks for explaining this! We originally had similar thoughts when
> proposing a w2sg0004 driver for the first time (years ago), but we can
> not accept loosing characters...
>=20
> Now, I could imagine a potential solution. The key situation why we keep
> the serdev open and listening is if the driver did try to turn the module
> off, but in fact did turn it on (because it was not in sync).
>
> It should be possible to cover this by a timer that is started
> in this case. If there is serdev data received after assuming the module
> is turned off, the driver has detected the wrong case - and can safely
> close the serdev until we want to have it powered on again.
>=20
> If there is no response after turing off, the module power state is alrea=
dy
> in sync and we can close the serdev as well - after the timeout (let's say
> 30 seconds). Then, the serdev UART can idle. We should open the serdev
> and start this timer also in the probe function to catch an initially wro=
ng
> state.

That sounds like a good plan.

> But I think we should focus on the basics of this driver first. Then it c=
an
> be optimized later on.

Definitely.

-- Sebastian.

--b3dmbfubuz4ltplf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrsYjIACgkQ2O7X88g7
+pqczhAAlYu484CN9moEQUVNT6heZ47nborx+QPwEiRNcPnpzP7N+h2z9CuKXpOL
/NbpEYW2gUguM629q5BSrJEbtnoQqbe0GyLvcqv9OE10Vwt/GtuiixrS6410AEJE
1yG0x/0QAfM2yYLxxl6ClzwH03uWgOqkMgJknyos4ov41nExQyZHA7zaqvj2N7l4
dhkp1gg4DeLDAqbznrDu9NwNMs/u3oGM3dcG/9veJ0QcVbrij6dsBoavGp+jT4fe
Rm1etml6w1F3UiGu7wQOuyyM4P6qIlFXhevZVqXPz8o1naIVfWktf4p1mRhLi85C
tI6+a9u0cI3MT3KPH2K+6u8lGf26egZHIEGzLX0giI8UBefSZ85QWdgSsS4VNBb+
uXxzRNtvisgjZ9WFBqL2OWJ/L/n04Y1Ey/dwUyQuoaXNSrAggVg5rYT0U4Xbu4BP
eR1UWvO9jy1eNOIZEx8ZxeTxBEducv99Z8T4BRqKbRnYmydPyO4VwEwpaqR2/1eo
dVVGNpCiuu3cvi6iJK/iyBjr7iF/CFSP5biE64RghDUv8X+lYPetsdMnwmIiMJ8a
hqDcaFtAOCRgEcj1OOZWIvYRuqop1SJlfqJLkGigEcVRJPFiXjT/ixG2ShjgbR0q
zIUSWLGgTgz4rXagyPOPhKqdck/ofqUKfAeqjwiXvoPNGJ5gvIM=
=Htwd
-----END PGP SIGNATURE-----

--b3dmbfubuz4ltplf--
