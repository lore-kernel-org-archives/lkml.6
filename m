Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCOJxv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:53:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36571 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCOJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:53:50 -0400
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
References: <d2afad3064f6458390ad692bec0edff9@de.bosch.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <3c417f16-b04c-c769-c021-44e69e0e4729@pengutronix.de>
Date: Thu, 15 Mar 2018 10:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d2afad3064f6458390ad692bec0edff9@de.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s3IlhwiyDNYRgnFvebZSvL7kKQASEPi7i"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s3IlhwiyDNYRgnFvebZSvL7kKQASEPi7i
Content-Type: multipart/mixed; boundary="1irmHvUwZTR12lrR6jyKHdkTYYvJ1hUt4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Message-ID: <3c417f16-b04c-c769-c021-44e69e0e4729@pengutronix.de>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
References: <d2afad3064f6458390ad692bec0edff9@de.bosch.com>
In-Reply-To: <d2afad3064f6458390ad692bec0edff9@de.bosch.com>

--1irmHvUwZTR12lrR6jyKHdkTYYvJ1hUt4
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/15/2018 10:08 AM, Jonas Mark (BT-FIR/ENG1) wrote:
>> Normal SPI?
>=20
> Yes, normal SPI (CLK, MOSI, MISO, SEL) plus two GPIOs for flow control.=

> The CAN peripheral (SPI slave) asserts the additional signals to
> request a transfer and to signal that it is busy.

Sounds interesting.

>>> I will have to check but I am pretty confident that we would be willi=
ng
>>> to publish the driver on these mailing lists as well. We will anyhow
>>> ship the source code (or a written offer) with every distribution.
>>
>> Sure - can I find your devices used and low priced on ebay :) ?
>
> That is rather unlikely. Though, you could buy a building containing
> one.

One building one device sounds like a bad deal to me :)

>>> If you are really serious about the review I will get the process
>>> rolling for an early publication of our driver.
>>
>> Yes, please go ahead!
>=20
> Ok, I'll kick off the process and start to collect the required signatu=
res.

Tnx.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1irmHvUwZTR12lrR6jyKHdkTYYvJ1hUt4--

--s3IlhwiyDNYRgnFvebZSvL7kKQASEPi7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqqQqgACgkQk9IU1zQo
ZfH9wwf/ULcPmAqjouCiyOmP4N7N/EVzHGSNg0bLoSdNbzsQUdAOjxVIPEJwsONF
LlGhye3zFprQnMrdr7CtCMMBwJ0oeyFSVcp0BknqGaWLCO7qAwgCgn5yk5XKaHEY
6E7tjqaBLbMKWz9fiOyfickbrPz0briSR2gTzMWNs848jSD1LDxvIWulurR3qnsD
acN9pc4YUURlGyOiyRfRrwgHy5speIjDwqeFS6k+82P8ypmcDimUhqoUNbvSW4lt
7bpeSE+MMEWmZtUNXnyeJh3B6Dg9xnXtwUNmMPW4tb7YI99+KIX9U0aAABJz8g9l
MjVUh9Gsglp+0X7RpQebvZDsef03/A==
=Imta
-----END PGP SIGNATURE-----

--s3IlhwiyDNYRgnFvebZSvL7kKQASEPi7i--
