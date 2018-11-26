Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F27FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD4E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hDg8lfQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD4E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK0DxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:53:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0DxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QOWq2o8h+E4RzLm6StrFwElTCCO+ymBLn99ky7pX93M=; b=hDg8lfQDD1n31E7DlCSAI8uH9
        dYEDmpNgHixJqC35Heox2HgBtpFRHSInlTu0XwbobiAQKBbfsuU56h6sUVzfsdmpCGrqAw0k2ipei
        8Fv6X4lLvN+yHfUKfJtOo+Snv1ZRyAHI3tNRy+h1kEWoQ/ztbNwk4Q9KX1P9/pn+EgTLo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRKDG-0005PX-Pp; Mon, 26 Nov 2018 16:58:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6AAF5112519F; Mon, 26 Nov 2018 16:58:22 +0000 (GMT)
Date:   Mon, 26 Nov 2018 16:58:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
Message-ID: <20181126165822.GJ9715@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 05:27:48PM +0200, Priit Laes wrote:

> +- regulator-soft-start:	enable the output at the lowest possible voltage and
> +			only then set the desired voltage
> +			AXP20x/LDO3

This is a generic property, there is no need to document it in each
device binding.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8Ji0ACgkQJNaLcl1U
h9DqpQf9FKk4EThhuaS+THyVIZabmB4UD5ThkwDPpdFPWnjv6ojusIg73Aqj0lnu
orthck0CTz+PCMPEXpdguWKQ7G9RjfgT9m+alt6294RpLM42RUVWfFPkzQjPFChb
CfTd2inKqv/5lzN3yS5EDZXT4CxLzGnn6QYFQ4DCeTYriqVjRq/LzZZ2ut6KiaH2
RfB22HvE8+Lp6qSwUc8yYyZ/Ri5HfjhKuDFSkzLXXSG2c35kZTY4k20V2dwfPLp/
J6RuZMpIW7qzbtg1SNqXN98AKvSmrBXuKvAbZV+6nRe1RBkpQiQeZOBMbfMFImtX
6nHUGaVsTpsiIxyE2J/jjlEJb0eIpg==
=gYOf
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
