Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB8BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B7B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B7B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeK3WPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:15:53 -0500
Received: from sauhun.de ([88.99.104.3]:57322 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeK3WPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:15:52 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 571D02E3542;
        Fri, 30 Nov 2018 12:06:56 +0100 (CET)
Date:   Fri, 30 Nov 2018 12:06:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181130110652.ckj75wrxxaez2sq2@ninjato>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nq7xysahvxit562s"
Content-Disposition: inline
In-Reply-To: <20181130105759.GK10650@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nq7xysahvxit562s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >  drivers/i2c/i2c-core-acpi.c | 41 ++++++++++++++++++++++++++---------=
--
> > >  include/linux/acpi.h        | 11 ++++++++++
> >=20
> > Any reason this is not in i2c.h?
>=20
> Yes. As I explained earlier to some people there are facts affecting this:
> - the function is operate on top of solely ACPI structures

And moving the function itself to the ACPI realm then?

I don't say this is a show-stopper for this series, but I just wonder...

> - there is already similar function for GPIO and it stays like that
>=20
> On top of this recently I've discovered, that i2c.h has separate #ifdef f=
or I2C
> and ACPI which theoretically might produce a linker error in some cases.

Is this something we have to live with or which can be cleaned up
somewhen?


--nq7xysahvxit562s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBGcgACgkQFA3kzBSg
KbavxRAAjKEwKlbD+2KGti8Ezmd3HXwE/DeJ8H+qNJqdWh8c3KdV5M2aBcESNVmL
UIr2ppYaIsHzRgDP50pZC3ND1u04O/EE4b+0kgYCka3gNbzig5eS1G/g5jYirdKc
cBES3w7UgtUK3p7hbuvqnloy/NkKvw0YZa9+Vl7wnaopyuHFWnNSvOvrJLARR+IL
ECbhWGjmVDgex16iwZwqrbAFQXSSpmariXFUEokVdL3LWnUhuKD0NiIyza8T9wV3
B1fT/02NOf/D7Xn4xBFrHB8bPL2HS1dmvsrT3gTm5pcdSk4XwyZ0VNMQd0JRazmH
Hp9StKw8aQC36CoOwMl6fS0UVvijTVgAgUk902+yqhtAj/DNHkz6EA1GjBj7M6d9
9dKa16q7bVizTcxYAIFOd6U7bdUwvP3aIn1Ri7TYJqmwoVvZghKFxai9XUraSWQx
OlhSQSwa1HDugpmjb4J2suLKgPrQkyLYJRE4w3d50QluYx0wac66HfUw3xmMN2ef
TTEjb7Z1wAVNqg/+iHEzvE7rc4j8z9tcGq+z8sD20d/Rpgxy+SWNLIZlTDNMoySl
LiunUhdKi8E66CTV8wU0o+VK4ntWD50gb8yMG1azGniZ3BhLgNw5CA7Rz2x7WpRJ
NiaFAsJAzIaSSZrWCqQWqfH04GIpOidBuSXb4Vbc9muqfcfA1og=
=I3U0
-----END PGP SIGNATURE-----

--nq7xysahvxit562s--
