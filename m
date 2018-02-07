Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeBGOSx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:18:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48590 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754008AbeBGOSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:18:51 -0500
Date: Wed, 7 Feb 2018 14:18:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v3 01/11] regulator: core: add API to get voltage
 constraints
Message-ID: <20180207141846.GC6003@sirena.org.uk>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
 <20180206163544.GI5681@sirena.org.uk>
 <20180207084744.GG7031@tbergstrom-lnx.Nvidia.com>
 <20180207104351.GA6003@sirena.org.uk>
 <20180207123750.GA5850@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20180207123750.GA5850@tbergstrom-lnx.Nvidia.com>
X-Cookie: 15% gratuity added for parties over 8.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2018 at 02:37:51PM +0200, Peter De Schrijver wrote:
> On Wed, Feb 07, 2018 at 10:43:51AM +0000, Mark Brown wrote:
> > On Wed, Feb 07, 2018 at 10:47:44AM +0200, Peter De Schrijver wrote:
> > > On Tue, Feb 06, 2018 at 04:35:44PM +0000, Mark Brown wrote:
> > > > On Tue, Feb 06, 2018 at 06:34:02PM +0200, Peter De Schrijver wrote:

> > > > > Add API to get min/max rail voltage configured from platform for
> > > > > given rails.

> > > > because...

> > > of the next patch where this is used to retrieve the minimum rail voltage.

> > And that in turn is needed for...?

> To calculate the required voltage for each frequency.

You're going to have to provide a much better explanation of what this
is doing - right now it seems like an abuse of constraints.  Client
drivers can already determine if a particular voltage they want to set
is available via regulator_list_voltage() and so on, that's what
constraints are there to set.  It sounds like you're trying to use them
for something else but you're really not explaining your use case
clearly.

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp7CsUACgkQJNaLcl1U
h9D8NQf9HArPCGOGdxVM2WXctuVLm1L69UeQZ4U5agoguZ9RA64DKMLKWWMWP9sm
XmnSvULmxvpwoRJG0lhRGlQKnd9PpsBiKCIcIixPgWRqdjEdfV8eFd1rKlpqUgss
ahAPnok+UzhsRJTXum2ibaZOyiQb6MDwyxvXvAXJrZ3fKQ68WpxMIvNLgTdx9YK0
/oEEbp4T/jSTLLm1Cf7+1OYJ64muqNh25QcxJR1S9UnlNw5qdEjUXaoQvL9XXxro
Su1vPDfnb0E+W0DEIBW8wWyJLGU8nmAOFX+mbPSukmq+VwQjBMzp66khYbpgGjVQ
p/CdoTHiJ+CI0E3ymlqYhkE6pkcXnQ==
=IooP
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
