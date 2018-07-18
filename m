Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC15FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB2E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oK8fAx1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB2E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeGRQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:10:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbeGRQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EGWPG/X8t+7T87KaLGsK9KHlTPYkLU73knm4fICMtg0=; b=oK8fAx1ytNTPYzENm/U0EFzFf
        zTyBiahHedowmR01Ko5aQjgID2FGH5LWma/HF8xOfFYRCVs+kKDL2mM+4wNaJtcM3OV0WcoVy5v9s
        cSuPRNn2fs2sYuipOzbQrjX0lrBD5mVYN2VSnmifj2LjQ6s8UjrIGySCjyosNyV/tmlFA=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoQW-0003gN-Vo; Wed, 18 Jul 2018 15:31:41 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoQW-0005BW-Cn; Wed, 18 Jul 2018 16:31:40 +0100
Date:   Wed, 18 Jul 2018 16:31:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-media@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH -next v4 1/3] regmap: add SCCB support
Message-ID: <20180718153140.GP5700@sirena.org.uk>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com>
 <20180718152832.ylu6rlcsaom2q4xm@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GIP5y49pbaVPin6k"
Content-Disposition: inline
In-Reply-To: <20180718152832.ylu6rlcsaom2q4xm@ninjato>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GIP5y49pbaVPin6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 05:28:32PM +0200, Wolfram Sang wrote:
> On Tue, Jul 17, 2018 at 12:47:48AM +0900, Akinobu Mita wrote:

> > +	ret = __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
> > +			       I2C_SMBUS_WRITE, reg, I2C_SMBUS_BYTE, NULL);

> Mark: __i2c_smbus_xfer is a dependency on i2c/for-next. Do you want an
> immutable branch for that?

Oh dear, that dependency wasn't mentioned anywhere I can see in the
submissions and I already applied this and created a signed tag :( .
I'll need a branch to pull in if I'm going to apply this (which I'd
prefer, it tends to make life easier).

--GIP5y49pbaVPin6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPXVsACgkQJNaLcl1U
h9DjXgf/axsR8NQUNk9IvtOlgTc/b9f/inR7NzaGZITDNx/h9Xt59O+lR7c/7k9x
8FrzAFuWll0JMhJhDtFHEV9IeraaxByMbIiVffaP0fVh1JWOeoG4jur/aQOvGiov
cEBrpudcsjyqlKvQHor2SqQz+GrCGuuK0zuFcv5Jpe0UV8C02zwGTiy7fAzJSvTC
pPAu/YnExqNOk/p8dj9xlWhBk77OrAS7d4PRDHoMIb0OSOazg0UJc6i/CiJfR2Go
EVRFNCIG+9hBOWEyXS0IBMmFI6tObVUztAmmlGQm5LrYPhNJQPw73O71MRcOy2vs
M5G4s54lbQ8B4D/gipZGKWI6QddT2Q==
=iQ+9
-----END PGP SIGNATURE-----

--GIP5y49pbaVPin6k--
