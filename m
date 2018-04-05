Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDEKH5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:07:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33498 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeDEKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:07:55 -0400
Date: Thu, 5 Apr 2018 11:07:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sergey Suloev <ssuloev@orpaltech.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180405100740.GA12349@sirena.org.uk>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20180405091913.ky4dnmszoobn2xry@flea>
X-Cookie: Last week's pet, this week's special.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2018 at 11:19:13AM +0200, Maxime Ripard wrote:
> On Wed, Apr 04, 2018 at 02:35:14PM +0300, Sergey Suloev wrote:

> > What exactly and in what way ?

> You should explain, at least:
> A) What is the current behaviour
> B) Why that is a problem, or what problem does it cause
> C) What solution you implement and why you think it's justified

Right, this is key - the top level problem with most of this patch set
is that it's hard to understand what the changes are intended to do or
why.  It's really important that people reading the changes be able to
understand what's going on, especially if technical problems have been
found since that tends to make people look more closely.  Part of this
is about splitting the changes out so that each patch does one thing
(which makes it easier to understand them) and part of it is about
explaining those changes clearly.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrF9WsACgkQJNaLcl1U
h9Ac5gf/aYWiN662b+5WIMt7jZMwx0qaXalRcZxf2FeQLaYdBbq8GlQ54uqSHzu8
plDSw8unB6nL1YNKLTbXlrY2HXP80abBwWVAOjlj2Dr//POEbMPOmMtiBRBvGvkf
EaKunDg1F+DsBpUV2J62x9vbixG3gHjCh4mqbMr1l9Bt9suj5DDr126rRkfGh5BK
TKMpisOr+grrT6wVcANovT9vofO2yH2sYTYu3KiuQ3ukA20hb3WgyxYELiggTT/Z
rKqoM3bPqwKWKBN17ONIp1k1r9j02EXD5MV0a9IWUi3quq6Tiff47bYoVXF1scrg
X9dWa7exq2ppwBJBWPij+tjHrQKqlQ==
=HryV
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
