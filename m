Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225D820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AuuYl4Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225D820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeH3OwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:52:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33388 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeH3OwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cR/A1vJH42gG/u/sn/uApFes4Yu/9U9fQPiTTPRb5Y0=; b=AuuYl4Ij3uD6L0f88l/Rx/jpd
        dN9n0yowAub7Bl92oAnlpr+ssPbcvvC0C5D78vUD9u/fDQxYlzlRUzBwevBR+OrcDk2l+Wv6HUMUb
        midaWkGNmrGvMysi6R+VY4NGSd/ilPx/X9foBT5xpW32zlq5rOQv+PRIhAe5eLv+Vq08Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fvKXB-000248-Sd; Thu, 30 Aug 2018 10:50:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 826E1112486A; Thu, 30 Aug 2018 11:50:41 +0100 (BST)
Date:   Thu, 30 Aug 2018 11:50:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio:
 add MSCC Jaguar2 support]
Message-ID: <20180830105041.GA7301@sirena.org.uk>
References: <20180829150955.GB7459@smile.fi.intel.com>
 <20180829151501.GE27808@sirena.org.uk>
 <20180829180242.GH16561@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20180829180242.GH16561@piout.net>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2018 at 08:02:42PM +0200, Alexandre Belloni wrote:

> Do you want me to send a new version or a patch that you could squash in
> the second one?

A followup would be best given that I applied it.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluHy/4ACgkQJNaLcl1U
h9BDEQf/Sg5eEdY++mdA1LKs0fAgW/QtDv2RvWwMtbwcBEUO2wuNeq7VyAANVOuD
Z6J92qS8/gES01pxny06K9pzGwwTPQMcM05BIqUFQb2GZ9drOxWtt36+WpXzJS0k
8fhVQaaeXzP97fEMwYklCGaeLhAa/+oCLt9P7AQl4v38wqQGYkIuLejUm5ThSjjp
I+mIecxcauO4heYwy7b5ScN2W43oEQjHgLOzH7i6iEsuVYFcn3AtjUZjcqEfODzY
T2ceA91nFvVBsXY+FXOH7TgYILAzwY0jLsPXgj1pTCflHiAL9+k+1214qUv0zmEi
y0deOslRpejH2Ezvg7n4oDf1zVePGw==
=USG2
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
