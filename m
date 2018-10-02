Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF32C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fXbAJHID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A9E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJBTpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:45:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43744 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeJBTpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fOfJTaTUvw4heKZcsjuIVaH3CtOjPR3exLN6627vVzs=; b=fXbAJHIDb19saZRpLrsnY7Drf
        9aSGA0UsivpzmO7+B/6lN8xe/D49PLYznZRSMTLM7gxULfZwOmmtD8eMur8GtBGgemC/fP8H9iQd4
        gVWhYhkVZMiNM+2mnY8/z2t9zmzhgu6mIhRcmvH8xWYyA+oYqMszDGkBCPRYsFCvHiuKM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7KJb-0001nK-2E; Tue, 02 Oct 2018 13:02:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9B62F1121CA5; Tue,  2 Oct 2018 14:02:14 +0100 (BST)
Date:   Tue, 2 Oct 2018 14:02:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the regulator tree
Message-ID: <20181002130214.GA6338@sirena.org.uk>
References: <20181002130748.61e33ad1@canb.auug.org.au>
 <20181002061644.GC9389@localhost.localdomain>
 <20181002162551.29b8c977@canb.auug.org.au>
 <20181002064317.GD9389@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20181002064317.GD9389@localhost.localdomain>
X-Cookie: Please take note:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2018 at 09:43:17AM +0300, Matti Vaittinen wrote:

> tree is correct way to go, right? I'll prepare one against Mark's branch
> "origin/topic/bd718xx". Mark, please let me know if you want me to send
> it or if I should do it on top of some other branch.

That branch is good, thanks!

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluzbFMACgkQJNaLcl1U
h9CpPAf7BnF8ZxjV+8FUQSer6pjw2VF/CJJMDbbje+C3OScYFkOFDzO+r08b4MJs
+t4DyaPPLgbw1+tdA0PZ9ZVqGfUVSKwExKRETPELkZzbBG/myqKM5rawKr4nzqFA
bL/sHY+eJo3u+3CymmxxqHF93Pv5by1V+I+seDuxlOrv4kBilaRP2RkvipBf3HkO
hDzeUDN2r/VibUjBKRC7Z6VOH4g3iPSf+ixD0QtU23d2SI8wdZ4CgdTQobW2x7s0
ikklna4h9X8H2InqIFIFyei9anIqGPHOGKDm148J9EEwrL7V1FDBGmXUIBSxOMiE
ULJUcH4VLS8vGKUaX+TTF5i4MxzvlQ==
=voIR
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
