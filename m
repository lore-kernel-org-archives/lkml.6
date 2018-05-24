Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965440AbeEXIe0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965120AbeEXIeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:34:23 -0400
Date: Thu, 24 May 2018 10:34:20 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v4 2/3] power: supply: add cros-ec USBPD charger driver.
Message-ID: <20180524083420.nna6znszz2lp6jwo@earth.universe>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwewbge7wkntr4mt"
Content-Disposition: inline
In-Reply-To: <20180502154418.2153-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwewbge7wkntr4mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2018 at 05:44:17PM +0200, Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
>=20
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
>=20
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

I suppose Lee's Ack was mainly for the no longer relevant MFD part
of this patch.

> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I would be fine with merging this for 4.18, but it has a dependency
on patch 1 for MFD. Lee, can you provide a immutable branch for
patch 1?

-- Sebastian

--pwewbge7wkntr4mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsGeQQACgkQ2O7X88g7
+ppC0A/+Nm4Um14DqLqFzNJErM13glYFxXn6QLFxtLot+0mYhVdyJUubBsNsVcOe
OtnAligIvxUxpPZOIA3eao57A+0mFHsHj4zyhFu9cPp5k8YkQcBNCGi38jxbJ9+P
8Zo3daak7ipxDIyqTB07q2GE6SSo/X+LpmV7jLKbiN6RQhfeNIQpBRWhdy4ZDqKm
wcLg45WxPgW30MXEpJSKv6CcJWNjxBfxijuSYW4OG6IReo2PUrE/aeogxHDBMUTn
k4G1icHQIXbVqdxivZhPqlYktqTfOqkDlVN9RcseIdTqp5AjZ4uA/1Er+Ml8vAwV
kQoIzI9jaIHcoA2xcQXn4cou+lMipYV4NSItjRbo+FWsOWdSJrD/PosrhJF3gmAC
iHE6ytzn3VZt5YgNS7XB+pFlDr/ISgb6HQiOHrgDi3ujnFrcXTFbVHRvBBZcffBw
fwcz9QOTzEhELDWjcf3/4bXs1kNFuZ/IyQ90QQkRYNbW0W6N/wpuTrMDlG22RARe
BBfqygJ2ze6iqvkp+/sdcuzElTkEsQu27uI7/Qa/xYqezPDRlF6NahqtAFAwDqW1
ddPOryMza/4CsCnSmkFRLbeOo8hBqzfq/QUoaSKcUOBZm4lCQaRT8SmfcZ+oiQLf
ePrKRRxEZTcQOj8SoeUebvMnfDx/jPfsHJ6d6aICOxGvTIlcn4Y=
=Pzq6
-----END PGP SIGNATURE-----

--pwewbge7wkntr4mt--
