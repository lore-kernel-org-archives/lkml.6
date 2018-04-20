Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeDTHO0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:14:26 -0400
Received: from www.zeus03.de ([194.117.254.33]:48016 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753565AbeDTHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:14:24 -0400
X-UD-Smtp-Session: l3s3148p1@Y1jpb0Jq7IggAwDPW8ZDAAId4P/+oMhl
Date: Fri, 20 Apr 2018 09:14:21 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Darren Hart <dvhart@infradead.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 40/61] platform: x86: simplify getting .drvdata
Message-ID: <20180420071421.ex6gcegotzjdswbg@katana>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-41-wsa+renesas@sang-engineering.com>
 <20180419235651.GC11546@fury>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3khbrrzjm7np76wh"
Content-Disposition: inline
In-Reply-To: <20180419235651.GC11546@fury>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3khbrrzjm7np76wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> (I'm not sure what you mean by "Please apply individually")

Right, that is not very precise. "Individually" as "per subsystem
individually". I.e. I don't want to collect tags and push it upstream as
one huge pull-request.

Thanks!


--3khbrrzjm7np76wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrZk0kACgkQFA3kzBSg
KbZT3w//afpRm3RefDNQ2Ysr5+0YF5JxKxGDkxsQbgVVAlWAjt4qsFsM1Y32PcWb
/uT7lJyE4mNSJie4OFT5X5Hcf9K2wWCO8cOtyDqysNdL7/+eJ/6vvjwjqIwYG6Jh
eGiq1H7hXI8m3f0xudQFjdKFdMkvQYYWs3VQ2U9wwlOP1AzJqTna7QzNk0hCN7jL
jyenIY2MsYK059MyE/qgDM0l913/O+3P4mOa5cA4OYGgX84MBc3i4DRrnhnEhLV0
StzkjAbHQKvVHNip802HC4ML6lDUlrlj3XUutlX78aSKZPs8V6NE3H7GvumcBV7T
WkH2Jv84jWt+IcF1cwPk5+T6c3rRXvRuRY01LpbsDenbxXPG4dQ0nSqQDvtdyo/e
6xT2Dk1fQ1PVIOPRyMqUJotg6Fy1+JklLVh8PMXpcEQuLbuy9wBmLFsC88U3AyMi
tUHbKGfArcITKQmpVacecTI44jff4Eyp77hWOjgujNC92Cj/PT0LPON/vHh6yYyi
ZcY/Bg6jAxZeHcroJmeVlph0vp6VU3GG7Cx6YJhcGYUWpBBo6HnKQCjOzlaIuvN5
NMWd5B0ZrjUJ/Awi8AOb0qzI7iyDJtZQ8O60wxPuwfG+4SZXL2KndwsdlZecrxGN
T5dEJRmA0oq1gSmtpMX3YznXDLwIxz7w3AYiIn2bXFHH/xWeOho=
=fyhZ
-----END PGP SIGNATURE-----

--3khbrrzjm7np76wh--
