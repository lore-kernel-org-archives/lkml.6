Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeCOItt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:49:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeCOIts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:49:48 -0400
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
References: <1e51047cd14048e99989ffcf9e10ffa8@de.bosch.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <dcf8cd60-e3ce-d8b0-2163-a5ecc3f00fb9@pengutronix.de>
Date: Wed, 14 Mar 2018 23:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e51047cd14048e99989ffcf9e10ffa8@de.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ku0VHNd9b4UrSULZDqfkhOkhm18hQltzr"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ku0VHNd9b4UrSULZDqfkhOkhm18hQltzr
Content-Type: multipart/mixed; boundary="yGJN0iw2500eSBlBrWTseytT0ZonzHrMI";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Message-ID: <dcf8cd60-e3ce-d8b0-2163-a5ecc3f00fb9@pengutronix.de>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
References: <1e51047cd14048e99989ffcf9e10ffa8@de.bosch.com>
In-Reply-To: <1e51047cd14048e99989ffcf9e10ffa8@de.bosch.com>

--yGJN0iw2500eSBlBrWTseytT0ZonzHrMI
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/14/2018 05:51 PM, Jonas Mark (BT-FIR/ENG1) wrote:
>> That doesn't matter. It would be the first driver that makes use of th=
e
>> feature, so we can learn from it. And you might get a free review of
>> your driver.
>=20
> Of course we would be happy if somebody was volunteering to review
> our driver for free.

If my time permits, I'll throw some eyeballs on the driver.

> The driver consists of two layers because the HW is accessed via SPI.

Normal SPI?

> So there is a SPI driver of 1000 lines. On top of that is the CAN
> driver and it has 600 lines. Because the HW does more than just
> CAN there is another driver which implements a char device with
> additional 300 lines.
>=20
> Are there still volunteers?

The SPI and the CAN driver would be the most interesting ones.

>>> Our motivation to separate this patch from the proprietary SocketCAN
>>> driver
>>
>> Looking at your email address I assume your employer sells devices wit=
h
>> this hardware and the driver. So someone has to provide the sources fo=
r
>> it anyways to fulfil the GPL license requirements. :)
>=20
> I will have to check but I am pretty confident that we would be willing=

> to publish the driver on these mailing lists as well. We will anyhow
> ship the source code (or a written offer) with every distribution.

Sure - can I find your devices used and low priced on ebay :) ?

> If you are really serious about the review I will get the process
> rolling for an early publication of our driver.

Yes, please go ahead!

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yGJN0iw2500eSBlBrWTseytT0ZonzHrMI--

--Ku0VHNd9b4UrSULZDqfkhOkhm18hQltzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqpn3wACgkQk9IU1zQo
ZfFqvAgAw3raVlx0A2ua9tfxKuNVwH48Mu8hAGlHCVvSf5tU+Yaebh12+Oa9v2QC
zVgopTOjYbD6PaEvAk2VEzq/W642D16A+xFSJo8RtsqOnkrsTMoUa+vYUm6OwVw/
trb+/xcHld8WQeoquYC13mSWe+QAapUFvywt4ncOVCbtnzK68gKzbRT6meO1QPlI
GB0e5ncanN5oqOhL1G70eQSoCFtUeBoNEQCFdpxMMgSRBDa90xMfLbDx2WgnQQqc
lkYIj8bRatXDyIxzRqRdXQVVWt+Ynha/7J8CQxUKmRpwoPnS1tUTJpnGEbQK4loi
Gk9FwVVOJ9fcnwMAZ3oAfSBoX6MYPQ==
=4XXL
-----END PGP SIGNATURE-----

--Ku0VHNd9b4UrSULZDqfkhOkhm18hQltzr--
