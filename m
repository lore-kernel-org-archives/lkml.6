Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDQROE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:14:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDQROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:14:02 -0400
Date: Tue, 17 Apr 2018 18:13:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>, evgreen@chromium.org,
        swboyd@chromium.org, Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] regulator: Fix return type of of_map_mode()
Message-ID: <20180417171358.GJ8973@sirena.org.uk>
References: <20180417171204.259146-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20180417171204.259146-1-dianders@chromium.org>
X-Cookie: Depart in pieces, i.e., split.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2018 at 10:12:04AM -0700, Douglas Anderson wrote:
> In of_get_regulation_constraints() it can clearly be seen that the
> return value of of_map_mode() is assigned to a signed integer.  This
> is important because the first thing the regulator core does with this
> value is to compare it to -EINVAL.

Hrm, so how does the compiler manage to not warn about this?

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrWK1UACgkQJNaLcl1U
h9CRfQf/ZwE1kXs4M0rxTOJmXVfzyrMq29AlqxDBZUfunp83PJ+EFPaNIwHAk3Fe
RnE3wqKPhB7vW7Bz6gMGaA7xDQ2Q/2smYeS6rpo/sckfNU9OJEwV90SnTvO81fNu
cqVzA7V5UDTNyY/oHrZOZW2pclV/nbXxtjGHZy+kuRE+ACSBfCWfhIe8hwizGjoL
HIWZDpw4n05SojU2oOP6Ds+MLenN+44r5ot17myZbOa62H0LksQXKmfjCcR5wbZ/
dzhEjlLG7BpT/iCSCLnmuYEVmOxrCdhpUijDacx6+JdkErQdOdxWDc0UokENolwm
Hq07Savx7YFS1vFOu/txI9dHTtp/RA==
=V9Qx
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
