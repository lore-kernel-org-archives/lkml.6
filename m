Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B67C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ME5ba8Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FE420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJMA0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:26:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33598 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nkNm0pNQcczh+mZcJoRwkg4aK/vn5OyCpzSAdKe6yJk=; b=ME5ba8QmMkgCbuSw1MPqO7F62
        YN3n4Ek3nixmoOedwIb9HD/WJ647oSzuFUi+ka5jXjQI5rCrs4bLDCM6VspULcWmfXnh1/yZ442qk
        dbV67+gCli5Qk9s2J67By4t5LsXs4tMkNmj0yL+xjDxRJFxIjdFRb0LqWOtuaCDgwIiV0=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0g5-0006cj-V7; Fri, 12 Oct 2018 16:52:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 50524440078; Fri, 12 Oct 2018 18:52:41 +0200 (CEST)
Date:   Fri, 12 Oct 2018 18:52:41 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181012165241.GH2340@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011145422.GG25351@sirena.org.uk>
 <153928658292.5275.11321177725702156165@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <153928658292.5275.11321177725702156165@swboyd.mtv.corp.google.com>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 12:36:22PM -0700, Stephen Boyd wrote:
> Quoting Mark Brown (2018-10-11 07:54:22)
> > On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:

> > > Is this used for anything besides getting the regmap? Can you get the
> > > pointer to the parent in probe and use that to get the regmap pointer
> > > from dev_get_remap() and also use the of_node of the parent to register

> > dev_get_regmap() is pretty expensive, I'd not advise using it in
> > anything that might approximate a fast path.  It's kind of debatable
> > when I2C gets involved but still feels wrong.

> I'm suggesting the regmap is acquired in probe and a pointer is stored
> here in this structure. That is not a fastpath as far as I know.

Ah, great - that's the intended usage.

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvA0VgACgkQJNaLcl1U
h9AWSAf/bRb9XA4nmyIZXZ01LsvCh9qzzhBcZK8rnMdHUgpTfEHzByErkofBCbu9
pkNZlcYzcBiyf4P+0zMHXJMzEXhX8OZzz4TQOZvTojgfo/UzhJFOJ3wFiuzJbqZK
FTbHUNcVPEOPE+kWkHhM40+ZxGG9ETD9sRWlnQjcMLlwoQLPIIv7vhmgljUJ+BM/
ZibZx7kvxYVEc11sPvkJ6WmMWJninFFRG9obj/R/Hsy/9OqNMVM1IUvSxFIWWPAu
0joXz/xBHyvhGx1U79Fcb5f+hMc5Yuvr3YzEaQjX+cxf1KZkS2qhnGc4v9EnCRkW
l14g4c+0bp32wQ57TsgcDZs0aDXKdw==
=zUtC
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
