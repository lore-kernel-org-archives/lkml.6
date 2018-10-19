Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B7AECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DF621479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VC0frfzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DF621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJSUMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:12:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33478 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QrxW8D7rRfOMb6FZeQwftIZIxKyrNvPfpc/hKDGoMRU=; b=VC0frfzBCzB3p3XV5OjFoZgN/
        p1nuUDz7CvA7oZcOrmG7O92XUT+PwSLOejuj/cPa+/yHQbnTDX3BRdNRHaNea5F6WvpI/szt53ao6
        trTsHECHEC5DBeuysHyoSSjS6IcWo85IsEfL4Q5X+8jcjzDp3Vs89xjF0kF3iqkdvT1Ak=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTY6-0008SH-O0; Fri, 19 Oct 2018 12:06:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 692B71122548; Fri, 19 Oct 2018 13:06:38 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:06:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181019120638.GG5895@sirena.org.uk>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
 <20181019112622.GB5895@sirena.org.uk>
 <70dcdc5d-73c2-d26f-6228-4bb0bb8ef612@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <70dcdc5d-73c2-d26f-6228-4bb0bb8ef612@opensource.cirrus.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 01:02:45PM +0100, Richard Fitzgerald wrote:

> Most SPDX headers on C files that I've looked at have it this way with a
> C++ style comment above a C-style comment, though some don't. license-rules.rst
> doesn't define how or if a SPDX comment line should be merged with the following
> file header comment. I've had a bunch of patches in different subsystems all
> accepted with this mixed format (copied from existing files). Doing the same as

Right, a lot of the conversions seem to have been done very
mechanically.

> Maybe someone should update license-rules.rst to make a definite statement of the
> style instead of leaving it to become another style that varies across the kernel
> and between files.

Well volunteered!

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJyM0ACgkQJNaLcl1U
h9Bu+Qf9HRCI5FYsAZ8g7C+A+by+0P3KD5oL0ehkyYz1+Ds5w3vDZteIwJ7XcMEI
GqnJE0Hra6d0d9xgqHkEAllesKNjCdu/R/Ihmuy7rtAkMU7LXWz0GVVT5hSMx4rJ
4kB2upnKZGFko7vV1zTUzCZE/MjJF28YVVO6bYJFuTLklQF+NlgkN0xpL+t3pmWd
yECmFZ7ep/cYlqId4WL7dbBMGgau7s5E47Vmt2bYWGvEGmuVd0RLWdRcpUXDeFIS
O9631tqUWAy4hN5WysvvWCJFOqaX3BoGdwoU3taxsqC3jhQCTg0BIhephFEtnxN9
h4lzwazFcKvKHytwxfqjf17Fu7/iuA==
=bXue
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
