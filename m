Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCMRs4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:48:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49013 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:48:53 -0400
Subject: Re: [PATCH v2 0/1] Open questions
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <ba3f53b1-e8bb-4c61-b486-19b9865d6e22@pengutronix.de>
Date: Tue, 13 Mar 2018 18:48:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI
Content-Type: multipart/mixed; boundary="bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <ba3f53b1-e8bb-4c61-b486-19b9865d6e22@pengutronix.de>
Subject: Re: [PATCH v2 0/1] Open questions
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>

--bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/13/2018 06:42 PM, Dr. Philipp Tomsich wrote:
>=20
>> On 13 Mar 2018, at 18:40, Jakob Unterwurzacher
>> <jakob.unterwurzacher@theobroma-systems.com
>> <mailto:jakob.unterwurzacher@theobroma-systems.com>> wrote:
>>
>> >> + =C2=A0=C2=A0=C2=A0/* get the urb context */
>> >> + =C2=A0=C2=A0=C2=A0if (WARN_ON(!context))
>> >> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> >
>> > Can this happen?
>>
>> Not unless there is a bug in the code. But we want to get a message
>> before dereferencing a pointer.
>=20
> Why not use BUG_ON(!context)?

As this will halt the whole system.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM--

--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqoDvgACgkQk9IU1zQo
ZfGnxAf/bHqg0zD/R0v3M1dsYUGCcDfamzj4iot5GBPbKNvxaLZCC6SRVKZG87zM
TP6htWEymi+Dq+ouJfXSQXk231A56JSeyNuF1Q6Ao5e+gzRHfOCKKJnC91vAqMCc
YSmBYDI9Fwi33I7C8AyNl/l4jH+0sCQUcSrr4CzcSs7YrOB9RKAKa129oId/y33s
bM9NEjGMIULCshYk2yDHkVInIrHq3VM1+c63GC3RgnL0j/c9oIm+9IVC+eCmKqRU
sb3IW+clqFeX6cvxsXxn4iOGYc47ns5I+REqEa9FyDf14zsuadhOMHleM4TBoHX4
XXataKvoS+cktczHg4NBe9HRxssxLg==
=25Mo
-----END PGP SIGNATURE-----

--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI--
