Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aE2YNxzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C56120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:15:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeIEQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vNIEumksZVRX8KEsmWJxJGBdfjGrHb60ydcwdktJWFM=; b=aE2YNxzPbj3SyGdkHH5D6b9v6
        BiengWKf4RbOU9umyooaZU93SIT68UHMxo4D7UhGcTTuwDoKlvW4oY8Ig0widohre5x2dUKQquzvT
        FV9NBSuGFgW3A0kODsSqGuTGJglszp240zsN5bWXGP9VAtTOv3aJ/DGpU/COfX/O5/XAw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxWFD-0002Cf-Ay; Wed, 05 Sep 2018 11:45:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 122C911229D0; Wed,  5 Sep 2018 12:45:11 +0100 (BST)
Date:   Wed, 5 Sep 2018 12:45:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: uniphier: change status to orphan
Message-ID: <20180905114511.GL9781@sirena.org.uk>
References: <20180905083137.23153-1-suzuki.katsuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Content-Disposition: inline
In-Reply-To: <20180905083137.23153-1-suzuki.katsuhiro@socionext.com>
X-Cookie: Two heads are more numerous than one.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 05, 2018 at 05:31:37PM +0900, Katsuhiro Suzuki wrote:
> Since I'm leaving from Socionext, I'll unable to access specification
> documents of this hardware (these are not public). So change the
> state to orphan until someone will maintain this driver.

I'm sorry to hear that, best of luck in your next venture!

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluPwcYACgkQJNaLcl1U
h9DojQf/W5uPo3TadqlvFPX890ObpeSx4cwJqndiVlaOgqId3UWQHmsCiHP+ahnD
ajfF2xbrJY1gtkuP4W95ZNtlaRquMSMf/MTWuDOYv/tZWxVWa73WgVP8mJEIDvM5
GFTQkqh6FfXX1AiWMOR1V9utzq8clY4AJ+9rrCB8yrIrkf8iJDoASsjxxsVPt1AH
tu4vV5mrMuivgkTjNtnlriu0eQ4DsCGMRxA5yZBo593zTsxJ/A31R8NwOaRAZrpU
CcCAhYUqlK28iU/IsOC1ESNdKwfj1zsO/ld043e9nvr2ZOFfjbjVlSwE+I6MrphI
D8JcCFZctdOzgDNaPYotJSPrgZWgNA==
=dfx1
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
