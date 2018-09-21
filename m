Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31E821477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="icLsL0jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31E821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbeIVAC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:02:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbeIVAC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lSxfByeVjdkA2vh7GoIghOSKc9lid1K+z4Im4Ho0RFM=; b=icLsL0jkW6qx2JMVaER+yQiID
        S7oirDGSNj8XrwcrgFTg2uCrm4rvPxnKE+r38zTGfovGsoU+iDvrEZz4HryItXt9v4uiZCyDtWEe/
        IE0ja8g9CwTvK/42PmfBnEq/otEhqim9GLKgmNaAcqclcgR1aIGgJmkJYkM21jBIiW1XI=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3Pue-0000jv-P0; Fri, 21 Sep 2018 18:12:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D2200440078; Fri, 21 Sep 2018 19:12:17 +0100 (BST)
Date:   Fri, 21 Sep 2018 11:12:17 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180921181217.GI20825@sirena.org.uk>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <20180921180241.GA4358@dell>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 21, 2018 at 11:02:41AM -0700, Lee Jones wrote:
> On Fri, 21 Sep 2018, Mark Brown wrote:

> > This looks OK to me - Lee, the patch is almost entirely a regulator one,
> > are you OK with me applying it?

> The diff in rohm-bd718x7.h does not look significant.

> You can apply it so long as you provide me with a PR in order to avoid
> any potential merge conflicts.  Especially as Linus is out for this
> release.

Great, thanks.  There's also the MFD DT bindings and another patch later
on with Acked-for-MFD tags on them, should I convert the tags to acks,
apply those as well and include them in the pull request?

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulNH4ACgkQJNaLcl1U
h9DfCwf/QRitJXFwyEvF50vNqxKDcwssX4NjRuVep4MnngUEVqS0EglOeKChgTVe
wMCqzduSR6k4t91hxuSSgm/p7PuXDFEDnr2fnhHGWyY1Jsw2AAPDpja67xPguNAx
6DeBbNlkbKTM8qVoEHYLjm57eZKO9VwH2Y3RJt8xRh3occL+XYVuZRb6U2XpErfr
P/iH1uHitrBdZMBx5datBKNlTe7Gi1ETpLq1viJ0b2hT+7XgOZy9MZikIzSU9Zgo
+s2sFVJZIurlgyZjD5PpciXsvMZPxWIDBVrnDZ0HVYqQhtot1Dts3XVlHZ3ZhMgz
/VXk2Emz8TkLq3RMLSqlEtOXsHwHsg==
=uNGQ
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
