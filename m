Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945943AbeCBKRy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:17:54 -0500
Received: from sauhun.de ([88.99.104.3]:53643 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1945930AbeCBKRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:17:51 -0500
Date: Fri, 2 Mar 2018 11:17:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: piix4: Use usleep_range()
Message-ID: <20180302101749.mbgvlugctf5t7rvy@ninjato>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfhhaqn4kxmukr3z"
Content-Disposition: inline
In-Reply-To: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfhhaqn4kxmukr3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 12:46:52PM -0800, Guenter Roeck wrote:
> The piix4 i2c driver is extremely slow. Replacing msleep()
> with usleep_range() increases its speed substantially.
> Use sleep ranges similar to those used in the i2c-801 driver
> to keep things simple.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-next, thanks!


--yfhhaqn4kxmukr3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZJM0ACgkQFA3kzBSg
KbayGQ/+OE8JvEeZZ9TU8jGgWmDMELklKdMwChAIGL6Oe5q06y4XFX45zE3of3cA
VffG4kScb3eVm4ZVVrHlCvKG3yPRpV/wo1p3OpZHPdjSQXFVUOZCG/xfmNcYMkC3
XgwSAYFQgmEr6qUhxRJNja4TU1auuYuw8O5N/jADtn3JwV0HFaecKgL+GiETC7hk
9Bfvb+uHlVuB4eLkti6cGEPemAK43k/szr1ipx/KY2kT8Xt4BENpST30b7Dya0Ef
8YxMQOFj0AVN8fJWsstUPs4LQQaVvBFWCOJyBgIipCrInjtGGzKwxaT2KcMJwfl3
QQUFh3Ad35cEv30uZmOZ3I0Cnpen2IQh5WcKlLXSsFHEkugBt7ror2Lm1aM9iIeT
DADEV/6dqxhDbnV7GaiW2o7LcYV2hZ5fRdm1gQQPcDIkmQtJcWUO4cLwfbegS+Ox
0RqCN5JoBzPeWXIBPrSIK7VBD3kokple0V5BwdZOtJQJC7uPIziwLA6YI+l7uOym
D/e4RFEMTIeeo5DCq/b7AB/Bau8ksw9ztt9ottL9cd3/xm3oC54HhZAqbaNxmWU6
okO6Vv0bY1nH/lDz+OwlHqR7KqWuWt6f5U3YnzAXbDH4BfyBk/0JXZHCbsrUlRD/
a1zqAruDHfF8zOzK0NHi7zR3EK8DfIqk7JLZA86QKGPyKkQAPNE=
=nVwQ
-----END PGP SIGNATURE-----

--yfhhaqn4kxmukr3z--
