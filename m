Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeDTHPv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:15:51 -0400
Received: from www.zeus03.de ([194.117.254.33]:48376 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753912AbeDTHPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:15:48 -0400
X-UD-Smtp-Session: l3s3148p1@ggX8dEJq7oggAwDPW8ZDAAId4P/+oMhl
Date: Fri, 20 Apr 2018 09:15:46 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/61] tree-wide: simplify getting .drvdata
Message-ID: <20180420071546.3itkcsjwx7zigyn5@katana>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <152417662884.46528.2642186598358773095@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xb62agcbzgg4mhzo"
Content-Disposition: inline
In-Reply-To: <152417662884.46528.2642186598358773095@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xb62agcbzgg4mhzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can you throw this into scripts/coccinelle/ so we can have the build
> testers run this all the time?

Sure, I first wanted to check if there were comments regarding the
script.

Thanks!


--xb62agcbzgg4mhzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrZk6IACgkQFA3kzBSg
KbaSaA//SfcR+doU23j0Kfgw9r3cXnvWgh4jKrIZDxPRA8eL3VNaspPPwvw1/q/n
gvw3lsSX9A87owt8V5iS26xTvkUYe/3dRZ6jeREvkZyAXhDhLgSzlsqzGB0QncWH
SWmi+We03pmUsFXCt2xUcwfLs6ZDZujz4jCBvpb+BP3OXefAnMzt6kB1oaGTwcF7
6Ps3h0TvI2y7kw63IwoU+IvF88zo4qJTPRyYZgNs7DK2aoZElk7oWjKcqvafXpP6
KFnIX2O9848l0sJ7FrVjpEsokEjlVuXM3PbTEhss6vTyABSC29/Sl/ApfMTBZ7jI
cEFjs/kkVNauetcbflvdWOZGlinGNYHb1NtPfUJ6Kfu9I6IyR6G1ABsq6F+62nZP
bfilUV4nQh7Bc8691k4k5LWp1c51VRoR7cQq0PoCI7mu7e7cRIrwefif1Jx2HB5H
P/r4IsiW0nqrxzVngDqcKKw0EPrVAh/ZoLXWv0tQR60KU7IsAwmHTohi9h2oAX1A
A8tlEzJhJCeg35Nt59gCDY0CqAwL9qglvpxMQU3qmFg+WQZL1oN7wUXay9/wPVyL
hoOmrLT0oKE9nHpk2YVVj8Psp+yvuCmeY3H04uqKrnP+vm2znkWfSGQwnVV7gD63
EvWuIc+gSCgLMw7bVG9t8Dlg82XkGQv6oWU862scm8fpsSW/G38=
=CoQa
-----END PGP SIGNATURE-----

--xb62agcbzgg4mhzo--
