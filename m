Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7B6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94312168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Zy/mIdgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94312168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeI1Tyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:54:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Tyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SE2aoMi2QEaIwaQKrR6OiGz4ZEr7Qfn/Q+KwToqnsJs=; b=Zy/mIdgmWKt/KlglggF6o2DMh
        v36An6lUgxRUxpN+dS6hPGgX+ZbiQ7oug//DhHMYsAxmliPb0Fd+0PfPee5KSThifVxd0lRkqDWkt
        pDBKJQYhXyKpVriIySr2+8aP9R40ydRNMTDu7k/ZeJBhDaqkzUtBBRY2Z61nhk55I1G8I=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5sr1-0008TL-2Z; Fri, 28 Sep 2018 13:30:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 94DC5440078; Fri, 28 Sep 2018 14:30:46 +0100 (BST)
Date:   Fri, 28 Sep 2018 14:30:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, sboyd@kernel.org,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180928133046.GL20825@sirena.org.uk>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
 <20180921181217.GI20825@sirena.org.uk>
 <20180921185258.GC4358@dell>
 <20180928071437.GB9389@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FC52J0nKTzya17Ed"
Content-Disposition: inline
In-Reply-To: <20180928071437.GB9389@localhost.localdomain>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FC52J0nKTzya17Ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 10:14:37AM +0300, Matti Vaittinen wrote:

> I was just wondering if I could do something to help get this patch
> series applied? Mark, have you had the time to take a look on pickable
> ranges addition yet? Should I do some rebasing/resending? Are you giving
> me a nudge if I can do something?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway so resending with any comments addressed is generally a=20
much better approach.

--FC52J0nKTzya17Ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuLQUACgkQJNaLcl1U
h9BtGQf/QFUaMLrG9eT2Ec/ViAZkRB7MpdFWjEgtcj/nvmgxzouVP0X+qku8pJOQ
F9TjXDjwV2mDxHRHOHfZoCNfSnm4XVOy+j8y/AnKVmXcuAwM1QFz1D7UVPO1Pon4
IpJOE5XVcgPCiiFbFFGcHuN55yeL0q2AddfKoAZueYWzB0Cv86DUJR5EMexbAlrw
w6Oxl+Fz+bFfJ36sMV5a/CeNt/uCPUbnd8blBTSp5vlRbyxbSIpDa9GTDBarqGcC
3rYdKsE1Czhlt/aPV41BDnN3mQbHD364auuWu4OTIcwTLAV6PRnm9wLCGyIbifpA
VWohT1mGMMtpTrdQVwjykIXPxgkG+A==
=AKQG
-----END PGP SIGNATURE-----

--FC52J0nKTzya17Ed--
