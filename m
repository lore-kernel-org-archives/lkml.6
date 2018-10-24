Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD31C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tzVljj2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F12A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJXTEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:04:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z66aFUtop78fBAqbmFHT7mMyY9v1mnDDR6KE8UTJc+g=; b=tzVljj2pKUMwJLFlIWcGVynTH
        Y3ibKBv7qFfjBZzI1cbmPSs1FnFmCfE63zlQ7yB3/8lSelMVDM1kdsVr8ypWji1wJ89w5exDVDHFV
        eDqEVHzKFD7ncLr19JPDykH+Gcca10C1sz2ScyIxWv+nCI79i5xvKjqobjrmsDLxPbxSY=;
Received: from [185.7.230.213] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gFGXH-00016z-MX; Wed, 24 Oct 2018 10:37:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3B17C440078; Wed, 24 Oct 2018 12:37:11 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:37:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Message-ID: <20181024103711.GN2103@sirena.org.uk>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
 <20181024075617.19548-3-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdWF/UuCWMRSqXrg"
Content-Disposition: inline
In-Reply-To: <20181024075617.19548-3-xiaoning.wang@nxp.com>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdWF/UuCWMRSqXrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 24, 2018 at 07:58:27AM +0000, Clark Wang wrote:
> Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

I'm missing both the cover letter and rest of the series so I don't know
what's going on with dependencies here - what's the story?

> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

Please try to at least have the git commit author (which would show up
as an in-body From: if you use git send-email), especially given that
it's not just a spelling variation but actually a different name used in
both places it's really not clear at the minute that you're not
forwarding a patch at the minute, if that were the case there'd be a
missing Signed-off-by here.

--xdWF/UuCWMRSqXrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQS1YACgkQJNaLcl1U
h9CdmAf/RBZVq2mu96SbISFysTMd4FiSr3nwNfAlxiyxAx/bVBlrpoDAjD7/pyJI
GV5ACm255IOkwCZbymD49D1wN5A6rFOLJ/VC2Mu71NBNUGUJIQ8qLuSzn87hYFhT
v+vwaGT+wJZxQhH+Sx3jhZSsVLfDkK2eunCHb+ABNK2nXlwiosi8EJOITd5di4Pu
ZkRc92UZHBEl4Io6PaMfFyMXeM9We4vnRd/Pujx6mzPe88pEjDWcc8Tk4MulIMEc
wR4K265UraZGsuJRWddNZcRPXyNkAP6TxTtstO8ULWG3vh985MhCUR2we0S4dH7z
RkovkCOK3CZcplbWMHQfeqpCPCiZEg==
=d6CN
-----END PGP SIGNATURE-----

--xdWF/UuCWMRSqXrg--
