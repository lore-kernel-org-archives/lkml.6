Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77BFC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF9620831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gPl0Z7ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeKUCkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:40:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uTesk2etsoL6IXRDcehVebOgmWnojIYoc53uEp/6eEo=; b=gPl0Z7ia6x1M4jfY7OYNcfcK9
        ZKPjRLSXasmQBxebS4mn8imDeFu+PDl6fZSIUoDIfJtEM5eSj1SlplPDxQDGJYf67ydcUEzzH3Z/W
        8po0/k6me/ewvWdGfZeSdctIOg8AXA4gAuR7fOBC4mdFp5Td2Xpf3pYgtuRKW/d7HlnX8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8c3-0001ko-Tf; Tue, 20 Nov 2018 16:10:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 888851124DC2; Tue, 20 Nov 2018 16:10:55 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:10:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] regulator: core: add enable_count for consumers to
 debug fs
Message-ID: <20181120161055.GI3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline
In-Reply-To: <20181120002654.1891-5-dianders@chromium.org>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 04:26:52PM -0800, Douglas Anderson wrote:
> Now that consumers all keep track of their own enable count, let's add
> it into the regulator_summary.

This patch series contains a bunch of random stuff that's not
particularly related to each other or even dependent on each other -
it's better to just send unrelated things in unrelated threads, it
makes it clear what actual dependencies exist, makes the serieses that
are sent easier to understand and stops things getting blocked on
unrelated changes earlier in the series.

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0Mg4ACgkQJNaLcl1U
h9DXfgf8Cw3g/7zctbXaR35e5TTiL992HX0b5zD9KcNh7DSi/TbfrAZX5waMdLiz
e7RYnc82tnOijxtpPl+T7AkUFlmJuZHwKJtZC/Z6Dh/aD0m0GYWYpKShu45vrdHM
0aNfnwbu3vja1qBxr3Xq8YEePu05kiJYFqaJTsucYercNh6stBdHE1qnyr9Q1Hmh
y1S4D6xCSi9dMXrbD4pUbAvPVxwTIr79+3Ek/qDAopYk+j+G6iRqtu1JNrgPSXZM
SeBbg/R5wKjunfi0H+SCLhxcHAuU4XGiwx0KHEAaROTAPNC/RlT0M3jc/Ae2+yOA
FJBg6ZGvafi5fPhleJ3AMOyoOvaO/g==
=2g5c
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
