Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B7C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBEF215A3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EaNLEZ6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBEF215A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeHOR3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:29:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50336 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHOR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Fqd1aG3l3+hR/qRfQuJnpn4ZifYE5KYJDkOOGPW/XE=; b=EaNLEZ6vllJ2Q4P2XkfQYrbOX
        s5UQo4JRK5IUIaab1iuve6XnITJsNSaNRwMlbYWsyXp1Zn/gDL7QdmuCBQynacL/IEYnwfH4mxU6B
        kpZzHj8j+1SBiCHq3tFQCt6geEJlrdCFY6XIsCH+Uwvdv6J0STSMLyn9tWttWopgFB3oY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fpwus-0001h4-OH; Wed, 15 Aug 2018 14:36:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5E2281124437; Wed, 15 Aug 2018 15:36:54 +0100 (BST)
Date:   Wed, 15 Aug 2018 15:36:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.stach@pengutronix.de
Subject: Re: Re2: [PATCH] spi:fix IDR collision on systems with both fixed
 and dynamic SPI bus numbers
Message-ID: <20180815143654.GA4581@sirena.org.uk>
References: <13c72347-d1fc-6250-3ec4-2066f9fd5e1c@compulab.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <13c72347-d1fc-6250-3ec4-2066f9fd5e1c@compulab.co.il>
X-Cookie: Captain's Log, star date 21:34.5...
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15, 2018 at 05:28:56PM +0300, Kirill Kapranov wrote:
> On 08/14/2018 05:18 PM, Mark Brown wrote:
> > Is this something that's actually happened for you?

> Yes, I observed it.

OK, that's useful to know - it differentiates between a nice to have fix
and something that should be sent to Linus and/or stable.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt0OoMACgkQJNaLcl1U
h9Ac3Af/b5/LtuJBFmE+04GEpatZfFFuDema+6JxAYO0kAkQsfMgu5XPXRU54f+J
+a5PFrZNOjj5s5qxeIqodXcpdaxE08IEy45oUmagegJ6otHXwmdOjIScIRCXPSxM
9mjfiexHjSPXuIVEHQ4F3le5k9OqBAeA9dW1LyUqWOQryTRu2hG1NkAw+kULm63R
WNSV3fblbeGb/Eqv5fi7cCc2LDbo40T2L4tcIAyB4zy3RTjjCpTEUEEhYhDHOyiW
91YkT0fyJzXxF8a0tEsKjMgU5S6i7366VuZ1t+Ji01e7K5Jnasr70p2U5wYxfSG6
DpCIC2uM775ORqnu33+pA3IAecnW/A==
=kIWz
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
