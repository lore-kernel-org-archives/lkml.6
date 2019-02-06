Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724212080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549468860;
	bh=nPqCtXfWi1tTHEiMzGbB8GZZOnJg02JE9JqzHOlkYu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aykO8t7U3qxx2+KoHMpeD9LjvFwON2s9lH+2i/k1N8oCcU9YO7MJkcurKcj7yvshG
	 pYRSEwqtPTi7H6PC+OaZ8sD5KMDGmQivxbrC8dWRLE6Bhhx52d3gI0M4ISUtCIPol1
	 ncOST12/1ROayzA1k5U31CweLyXPl7TzC7I4BAB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfBFQA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:00:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfBFQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nPqCtXfWi1tTHEiMzGbB8GZZOnJg02JE9JqzHOlkYu8=; b=XNcEp53+ZhEHv7lSGcL9mLMPu
        gZLBxFcQhxcjO3gRWq0ahAFIIMog8BLkns2VJDBfftfE6weI6gwUtq0wT5BG6oQwipIveVG67aBtn
        IvB6LlxH1iqb72GEZ1y95lXNb7Pdmu3CDJi40lG7Rwqn5G9On0L/3ZZ9bMpO0jF/xSJa0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grPd1-0006rj-GD; Wed, 06 Feb 2019 16:00:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0179F1127EA3; Wed,  6 Feb 2019 16:00:46 +0000 (GMT)
Date:   Wed, 6 Feb 2019 16:00:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5 v10] regulator: fixed/gpio: Update device tree
 bindings
Message-ID: <20190206160046.GC17630@sirena.org.uk>
References: <20190129103156.10139-1-linus.walleij@linaro.org>
 <20190129103156.10139-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20190129103156.10139-3-linus.walleij@linaro.org>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 11:31:54AM +0100, Linus Walleij wrote:
> Deprecate the open drain binding for fixed regulator and indicate
> that we prefer this to be passed in the GPIO phandle flags.

This doesn't apply against current code, please check and resend.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbBK4ACgkQJNaLcl1U
h9CseAf/VJkhE6U2+YKUYS+lbkRl+ZeCiefDx7XX9vs8ejvfyQJ9hdGcefzygUAk
jIOm7GwsW1DHMtRGtGmKTbFnF/9Y+D76QNQg6q9liud3ytXvHJy/nzoiVvbFK94h
/NzmEdj8bEQ5T0eDp/3vlGiDnbe33wbL6/imgWLf+AWoFfq59h/7tm5Tu6Ru0lAr
aRawqhcVac4fZfpOM7x3dd5PPesULkiZcvNT1dk6PNSvfMFjOPY7a8Ov+PoMydrw
08oyTVCnXPmC2N5bsVmv3+mF8yyReRU+3l1WI/B/Ne8FEO0QyP0+cwGYZORDtlmK
g6xf86yesFluZs10CCHCxSWAXHl4Lg==
=5aFR
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
