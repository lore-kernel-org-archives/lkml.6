Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF29C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AE820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RLwmvu12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AE820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeKTXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:55:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeKTXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uG7ZfvqKHS/gsAstyyoQlPerxmRcMGKTcvg5+SFbCPc=; b=RLwmvu12wC9U85Ri0WVa9Olw8
        CBtJOV/bkj6qQDGqwzIGLeyERpJ5knxsqYlyQsJU6NVDOZsJZkxzVZftJjzZLZc9sLGl7zpClItPv
        mzZCUOWwKSwU6WO2peAEgVzmLmuW6y31OIfzbpGnRpywHD9SCtKxQRrVrroBomh2B0NhQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP62r-0001e0-1X; Tue, 20 Nov 2018 13:26:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B8AC61124DC1; Tue, 20 Nov 2018 13:26:24 +0000 (GMT)
Date:   Tue, 20 Nov 2018 13:26:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Message-ID: <20181120132624.GD3894@sirena.org.uk>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <20181119152735.GB3535@sirena.org.uk>
 <cbbc3dba-7f85-c6a3-525f-01eb23e50592@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <cbbc3dba-7f85-c6a3-525f-01eb23e50592@gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 11:10:04PM +0100, Marek Vasut wrote:
> On 11/19/2018 04:27 PM, Mark Brown wrote:

> > The SPDX header needs to be C++ style so I push people to make the whole
> > block C++ otherwise it looks messy.

> OK, I'm not gonna wrestle you on this, but I think it looks horrible ;-)

I don't really like the C++ comment in the first place :(

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0C38ACgkQJNaLcl1U
h9CYugf/TazL9aK3m3BZyQu2PUROTfRLBMASGfFwET3KArzqBENiLz/YCQptBzbE
OKnkCdELmTUgyMWSMkwM5QdLhRK0eZeeVC4Roa5z3ZiotEcPW8uaslW4QYxZss+j
a9EVALvMfhJBHPNFh6Joxr6ld4kBV/o9sa2zWBdoKFZ7dL39c8v8mpzQ12oh5WtR
i4R2hUW+tHfuKxNb0jILPnXq+IU4wnrvVTaWKYgEMS/vxCtHdRuN6+TQBfZUqlvF
a1IUEczKBeGFCT9ulvAdvUhDFaU+eKfEcsl2jaqo/gDnDoqRKCBV/l3xcL+Nu7w/
CGpEAdlDS4uJw/ionK8ai1fSXq8Stw==
=wvCr
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
