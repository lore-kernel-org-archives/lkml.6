Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeEVRcV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:32:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48932 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEVRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:32:19 -0400
Date: Tue, 22 May 2018 18:32:16 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mahadevan, Girish" <girishm@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180522173216.GH24776@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <20180503233849.GF13402@sirena.org.uk>
 <0c26e96c-85ad-c2a2-9abd-33096d76008b@codeaurora.org>
 <20180517072114.GS20254@sirena.org.uk>
 <9e8c271f-6373-b0e3-ba74-8a776b09c1e1@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <9e8c271f-6373-b0e3-ba74-8a776b09c1e1@codeaurora.org>
X-Cookie: I have not yet begun to byte!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 21, 2018 at 03:45:09PM -0600, Mahadevan, Girish wrote:

> I can resubmit the SPI binding documentation as part of this patch series.

Yes, and realy I'd expect to see the SPI subdevices being documented in
a separate SPI binding document rather than just lumped in with the
parent documentation.  The same thing probably applies to the rest of
the bindings in there which I'm guessing have also not been reviewed in
the relevant subsystems.

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsEVCAACgkQJNaLcl1U
h9BwXwf+PC9/gYupCwaYhEV7tms5eJppMYWLDPWITaR+XD//KQYbOLWmYIvEGl8p
KMR/W4X9f7jMRBphwKHcrPUlKWfBAhPWxGU699OqAX2IxbRhFzi1t4AZqmg+zXkr
GRfrxiIcu4Q3YNWiQDKBjnDCEdDZNr8wZ99nGaLmuqL5ZlscTz680KdVT7b1pg4J
8Q0RA2vnfdb4zBltZUXKuGs9/2w35Ac4CCXu+yGXOcrufqPCyTV2LtBQ02wjeYhC
DVSOA/PpR3gDg9qTJHcMJ2o8jWP5PwkKEZXNFUjicjKl6CXC7BuJFWa1993xC3VX
WJsgZV6KaScyO89ANbymywNwBeMuSQ==
=Vfz3
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
