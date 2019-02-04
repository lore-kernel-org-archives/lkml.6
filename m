Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA74F20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277873;
	bh=l4l00d8kO6EBNvBOlcLDEZrFrqDgioAWz1X9WcVf7bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D1Wv+MhhxQrvInbD0GMabPhPGO5c0ieDXqw0biSULoZBi13HIOpcKozCV+GTfLh0e
	 ia70yenlGU0E8TGJe4KATbmuDUByXsIIiMRovA6IbA8JmXcpyDPE0uu4n76wseuZc9
	 fMQ96+oZ8uSgqe2YfUHm9SfcYCY2nOdyScg8UM2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfBDK5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:57:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfBDK5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N30741cJ3E37/0D4+jvMwReZMBidZwLRwlGFgb6p+dg=; b=GxUPdZ+4RIU9K2woGa+OL1+wY
        1bsDevDh5iUrSAxh9L4pPnDN1wVZHoljAYDEvj67hFHH5jaMesZmXmFc29gLRbhp6YIG9xDtglmR9
        s/FJ/Q2HdyeC3032jooOcvkXmnHR7PfhdIqVH3twErbmwJAdzU0q2FzX3dK/heVV0qLvE=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqbwY-00024D-Ic; Mon, 04 Feb 2019 10:57:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2F603440082; Mon,  4 Feb 2019 10:57:37 +0000 (GMT)
Date:   Mon, 4 Feb 2019 11:57:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Message-ID: <20190204105737.GE23441@sirena.org.uk>
References: <20180927150709.17010-1-lukma@denx.de>
 <20190109082644.14941-1-lukma@denx.de>
 <20190204113001.77d59570@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <20190204113001.77d59570@jawa>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:

> Is there any interest in adding new code (or fixes) to VF610 ?=20

You've been sending ARM: patches to me (the SPI maintainer) and one of
the DT maintainers.  You need to send patches for that platform to the
relevant platform maintainers, I only maintain drivers/spi (and some
other subsystems).  Similarly the DT maintainers only maintain the
generic devicetree stuff (but apply relatively few patches directly).

Please see submitting-patches.rst for details.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYGqAACgkQJNaLcl1U
h9ChZAf+IMhKOXOta9O9aHuoCBQ2p2TtyFCR4Zf2n3kP69uR4e+YcTMGEkUAQELe
48mrri6qhni1vhrInwLawEhMcF5bHqwnAZm2E3H0JXYPSoI9PCKcwqKnsMnlwg7x
k5scsb0IguVujXN8fjnBFwUDeBGtS7FCd7sD+QCPGJ9KsGyyFHWrCQQTRpkiux4g
wUWHFIU31wnwM6JPjfaRIge37sS6UB7lWnwJp0InQIFbtq/OK6H4R7cOwamAx3uL
d5OjWB/dX5mpYPhVpRC3bzQWyKJnOsLAoRgSsrmaWawROEWr5tiuNXa4MqT+15Ed
5LBkorkLIX0r3GTyuY2j1uEdeT3XMA==
=LwcP
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
