Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeCEPxI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:53:08 -0500
Received: from sauhun.de ([88.99.104.3]:40123 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeCEPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:53:05 -0500
Date: Mon, 5 Mar 2018 16:53:04 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: verify the device id of the
 pca984x chips
Message-ID: <20180305155303.i4zut6wtwckdes7z@ninjato>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lg4msgmpcqno4vgt"
Content-Disposition: inline
In-Reply-To: <20180122113657.32094-3-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lg4msgmpcqno4vgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @@ -97,59 +98,83 @@ static const struct chip_desc chips[] = {
>  		.nchans = 2,
>  		.enable = 0x4,
>  		.muxtype = pca954x_ismux,
> +		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },

Can't we just leave this empty and add a NULL pointer check below when
testing for the device id?


--lg4msgmpcqno4vgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdZ98ACgkQFA3kzBSg
Kbb3UBAAkk/sUqKBYyLi0vkh+bNs5VLdNwz50/grqmYBaneuYV99d8m81UB9wNHM
PdPzycuPQzqQhB2yLXnQGNYLSq0NVl6iazm3N8lqTZZccvvqE8d3Ld2zYb/50huN
DYD3x+M4rlxkt6pY2lAdexyC9KLGJJSSSysVqmGJHGlYJcIr7AMm7Ue/jLIpwU6T
ObDVsXVwUOGJf+ilas+4fvZJMHund7pa3Z5xHG2YHylLzTMfpt6WnrYJzFcTpQf3
sGqL1APiJUEWOuOo158Tvjvbdor9/LocZUYzq/HjzNg1sn9zkQne8zL4zot07viN
E7Qt/uFLiiTWm1vSx6TBqf44ZycCXMytofe1+kK664YxfavnSHjxqZjmDq44kBYl
C5lpcfIMID68m611WaTcelYDUKmU4WKMX7Cm/PYyGfuQHpDxObF+oqq+zJ74VXNB
TVXQZmH3Hg8mi9zGn5P6h6c8qhnipY4wI82NX4X3mDLdNTPTFtRzNF45kWT5Etso
bnbFFyqkMMznKIiFBLzX4ETlbUto8byfxvkGaQDTPxF5XdKg8cfTZhA4H1vyCAUT
UzNIGBoeniAdljFZ/hvpqS9DS+U9UBzuIH9kvUOsxks7x7VVDHGMUXx3Yag9LDgt
LNVfikc7VHq+qW0P9yOmRodOl7X5UmmATHvh29+Ji02Nw7AQRNo=
=KPVr
-----END PGP SIGNATURE-----

--lg4msgmpcqno4vgt--
