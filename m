Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E9C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F602081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544456490;
	bh=ZFUANXZ8s4obboI6e1ASyk6UmoBwr6/jzVEu1BMQwwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jg+WciN1JN/wSMfJzXRQfrqE7DZN1rb+Zg5p7igFKW7zK+RkIG8huhtGyVEq/TvVx
	 mofIuOG+ehd0Fao7SPMqK6cEuLEwocZa54Op/TdU00c6bzpPNWzbeOW8OgzyPluSt3
	 0THzG6h6r6wwrKnrLgjKGST5QkdJYmMs9cRiighw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F602081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeLJPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:41:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeLJPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DB5wuq/JeN77p27oSYH3LFDhIzu/S7XLSrQYXEydFJA=; b=DIHy5U5aDO8nBbzN0/smx0U8Z
        fVC9gbgb8nWk5hWifx5wlrsqw9DrGzlyP1/KFnG8W3Xc6JWPu2UYiYY+l6KTdd6BwQz/d2wJPMn9P
        ZZdlkMZlBSwv9zwtQHRmeTtX3mO+5sDB4zlplo/Q0AQsdp4DriEpw+j9xDT54OQXpgJR0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWNgU-0005C8-6X; Mon, 10 Dec 2018 15:41:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AB6CF11254C5; Mon, 10 Dec 2018 15:41:25 +0000 (GMT)
Date:   Mon, 10 Dec 2018 15:41:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/2] regulator: provide
 regulator_set_voltage_sel_regmap_step() helper
Message-ID: <20181210154125.GE6307@sirena.org.uk>
References: <20181210151024.3906-1-brgl@bgdev.pl>
 <20181210151024.3906-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20181210151024.3906-3-brgl@bgdev.pl>
X-Cookie: Do not cut switchbacks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 04:10:24PM +0100, Bartosz Golaszewski wrote:

> On some devices we need to manually ramp the regulators to desired
> voltage one step at a time. This patch adds a helper routine for
> regmap users that checks if the regulator is enabled and, if so,

My first question would be why do this at the regmap helper level, why
not do this at the core level by stepping through selectors?  I'd also
expect to be programming the step size here, while some regulators
aren't able to regulate well over larger step changes I'd expect that
they wouldn't need to step through every single possible voltage value,
that's potentially extremely slow.

> +	asc = diff > 0 ? false : true;
> +	end = asc ? sel + 1 : sel - 1;
> +	asc ? curr++ : curr--;

Please just write normal conditional statements so the code is more
readable and hence maintainable.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwOiSQACgkQJNaLcl1U
h9Aa3Qf+MAznvOcxNxouWNrZQJdprFCGRXAmf6UVq0BfszHUB3Wf5EyI8fLirhMI
J8zK/llOwkcHCMtET2lDCIZrRqx3OulZaqVzU2puWyvYJ22wmhv611LjxwrMi9tg
3EwpGCE0kyw0Vvg7/QLr0gRgR5CQ0tMDSd4xsi2TOyUVhXvin/xEZNoW5z/2ev0J
3zrXy9bxeJymVxLWW0p6a9TGQ7A7WsJEPpHPRR4HP6eRW+4JoXFbhltokAJiyZ0W
Jee/Kqyi4KiJFqD/E/0j/DOatlbnKFOsg/ABQoY1ACzWvB71mptJvjRN7xs8PUdM
HrdTrWiDxd8E9UePutk32EvYApw0PA==
=fIfi
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
