Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCNMon (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:44:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeCNMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:44:42 -0400
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
References: <9ce65a3a1535456dbad7120c5775a8f9@de.bosch.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <7cd5b1e3-5d86-1f3c-e651-448d696a0823@pengutronix.de>
Date: Wed, 14 Mar 2018 13:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9ce65a3a1535456dbad7120c5775a8f9@de.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NjTT4RXgDvMfEI53KONn9meUQ5VFRRgrC"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NjTT4RXgDvMfEI53KONn9meUQ5VFRRgrC
Content-Type: multipart/mixed; boundary="arCDEgYDoXUguQgCngMyZ3uhBNGiddoEm";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Message-ID: <7cd5b1e3-5d86-1f3c-e651-448d696a0823@pengutronix.de>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
References: <9ce65a3a1535456dbad7120c5775a8f9@de.bosch.com>
In-Reply-To: <9ce65a3a1535456dbad7120c5775a8f9@de.bosch.com>

--arCDEgYDoXUguQgCngMyZ3uhBNGiddoEm
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 03/14/2018 01:26 PM, Jonas Mark (BT-FIR/ENG1) wrote:
>> Do you have a driver or a patch to make a driver mq aware?
>=20
> Yes, we have CAN hardware with multiple queues and we also have a
> SocketCAN driver for it.
>=20
> IMHO the driver will be of very little use for the Linux community
> because the HW is proprietary.

That doesn't matter. It would be the first driver that makes use of the
feature, so we can learn from it. And you might get a free review of
your driver.

> Our motivation to separate this patch from the proprietary SocketCAN
> driver

Looking at your email address I assume your employer sells devices with
this hardware and the driver. So someone has to provide the sources for
it anyways to fulfil the GPL license requirements. :)

> is that we felt it was odd that the multi-queue infrastructure is in
> place and only very few lines of code are missing to offer it to the
> CAN networking subsystem as well.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--arCDEgYDoXUguQgCngMyZ3uhBNGiddoEm--

--NjTT4RXgDvMfEI53KONn9meUQ5VFRRgrC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqpGTIACgkQk9IU1zQo
ZfFq3ggAqD2LOcpwBk3KTi4BGSjsenhZPIKEng2TIHHd+8Sb3xomGBA0WA27Ij4H
om7jpD7AetBaHUDMljHO4PzIkkTacXdeu+e5KRfJIZJjeLC6Enp4pc8UGbF3qqDZ
JbkRETxSZ2r6MxLXq1hYXHOGty7ks6DZXeag4O4Z9eXeYBjxt62xOgi0hBICfpMW
56ASz0Sz/lb7HAAByip/lt9Mjho8IY6e7jevjbm6ZiYWov68/ChpU3XrfBIXbZAA
27U1NMko0LHRiPrbU7G+gjRnKys/NHWkG3FR+FRIosbsAA8uRzEV/dqSQRi3gVZc
GuAQwTJvg9dXiDyFw2mS4Ml1di3zLA==
=e8Pv
-----END PGP SIGNATURE-----

--NjTT4RXgDvMfEI53KONn9meUQ5VFRRgrC--
