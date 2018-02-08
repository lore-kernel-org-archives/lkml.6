Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHOnj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:43:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:43:37 -0500
Subject: Re: [PATCH] can: m_can: change comparison to bitshift when dealing
 with a mask
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <f76988fc-db62-576c-7cba-58259cf9edf9@pengutronix.de>
Date: Thu, 8 Feb 2018 15:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L3QZrDHeHWdmduPP8K6NTogOucdTWDtx4"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L3QZrDHeHWdmduPP8K6NTogOucdTWDtx4
Content-Type: multipart/mixed; boundary="glwg4TysMLh9Tqp1Gw8ayyXwr3iIaA7fQ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfgang Grandegger
 <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <f76988fc-db62-576c-7cba-58259cf9edf9@pengutronix.de>
Subject: Re: [PATCH] can: m_can: change comparison to bitshift when dealing
 with a mask
References: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>

--glwg4TysMLh9Tqp1Gw8ayyXwr3iIaA7fQ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/06/2018 09:52 AM, Wolfram Sang wrote:
> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Only build tested.

Applied to can. Luckily that define is not used :)

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--glwg4TysMLh9Tqp1Gw8ayyXwr3iIaA7fQ--

--L3QZrDHeHWdmduPP8K6NTogOucdTWDtx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8Ye8ACgkQk9IU1zQo
ZfE5ngf9FfC2VYJ1KD8HcsAYc0Hh9ByscFKRPNMGoAPeLKG5EMvDI8CN0oZXUZCg
CxZfqEXjcrzHor9YaJAX/mAKNcoPGrypXEtS6jQ1KCNh6mnSNUXGlueLgZ9N8a7c
rAVey3wSfQA0c2vlZH0u5eoFC9pCDIAai1TXn+wrvolQPcYVBpmOyqNJGwlERF0Q
SPEXCCHCn3tO+BR2vc4vJYRvTkqGyPUKF5b+dlaBWncbRo64E0TCpAmjfiToPt3o
Fpp8YCO42IY2cdXFM7tEN4LHzC/TJFggWQyccba7CwtwR3vf93keFGiMlor53wCn
4RwxobFxSvBypIqy1s9lh50Ky0XLkg==
=jnP7
-----END PGP SIGNATURE-----

--L3QZrDHeHWdmduPP8K6NTogOucdTWDtx4--
