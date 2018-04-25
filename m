Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbeDYPe1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:34:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38275 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754701AbeDYPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:34:25 -0400
Subject: Re: [PATCH v5 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180411160642.18383-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; keydata=
 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
 /6jKeO1yNpD5UgI9bzazBn1mwg==
Message-ID: <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
Date: Wed, 25 Apr 2018 17:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh
Content-Type: multipart/mixed; boundary="6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
Subject: Re: [PATCH v5 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180411160642.18383-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>

--6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 06:06 PM, Jakob Unterwurzacher wrote:
> The UCAN driver supports the microcontroller-based USB/CAN
> adapters from Theobroma Systems. There are two form-factors
> that run essentially the same firmware:
>=20
> * Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )=

>=20
> * Mule: integrated on the PCB of various System-on-Modules from
>   Theobroma Systems like the A31-=C2=B5Q7 and the RK3399-Q7
>   ( https://www.theobroma-systems.com/rk3399-q7 )
>=20
> The USB wire protocol has been designed to be as generic and
> hardware-indendent as possible in the hope of being useful for
> implementation on other microcontrollers.
>=20
> Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-sys=
tems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD--

--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgn/EACgkQk9IU1zQo
ZfGGrggAz/8gUQVrmb5C0J9RLm9kYcLjjSZWci3ww5Ra6ANxvK7iCDIIV5T8TYW3
lrUqZBVbOjghaIDN6mcaLojulTCsAa0EPpe/l/P/bfAbpX8LXa44zMLm2ipz8hdM
Ndt1DweJfnGehELlWLH3CiqxbqmUiIvybuJsQL271jHwmhWhoMX05Mu26bW+bVLM
LPWsVn5FrLbBths/oGHJ+n2sRxTC1goMYvk6FnUC12O9hu5i8v1O6XRgDHv/SeD3
s7YiGtHLQmPq+jrw27Fc7oNA7FACzAHEb9+5T90cGdoQA85P/1peBySGXc1V4zPu
M1bev7cb//XpMdXufZ41fId7n9r96Q==
=WhMW
-----END PGP SIGNATURE-----

--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh--
