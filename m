Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5C92175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552948;
	bh=PTgxcrKZEGZaYUBtwh+1Y+aVqfKRIiXfj4FANeJNTnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5Q8k3nRjOeZ7E+yKA5TaO/PDLJS++m6+7awZTnrm/BCGfq8votOaLG7sNK7fwtRI
	 SOICHtZlM8kcQ6WFI/H3a5hBYjZnj9qdLRbEjiSahSG93mNqLP3tPM/sBXBJrUE3G5
	 BPrhf4GythbdqGxVIX785wbtYe7U3+ZTiPOlkyTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBGPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ihg6DlFPpxYlK1dQEydjW4cI+RIQqRRMBP4/ALPS8/Y=; b=DdH8J0cSTjfajnHgGI0Circ1t
        yCnb/Ar5gc/q0DX8LoNBBFFC00OnbYxXh/h3VK+Cljh0IdIOp3l/oGD6Uu5oKVGTLUWBuHhvrvTNo
        9mCPDZC9nQUFO2ZnZRccHGO72ByLBTdrnryG8ZwZNkKbqfw4sxMG4ISULe9s7HDrMWO6U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grlVE-0006Nn-M1; Thu, 07 Feb 2019 15:22:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F3EC1127EF9; Thu,  7 Feb 2019 15:22:12 +0000 (GMT)
Date:   Thu, 7 Feb 2019 15:22:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
Message-ID: <20190207152212.GE6190@sirena.org.uk>
References: <20190207133143.5232-1-paul@crapouillou.net>
 <20190207140031.GB6190@sirena.org.uk>
 <1549549058.24598.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <1549549058.24598.0@crapouillou.net>
X-Cookie: A day without sunshine is like night.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 11:17:37AM -0300, Paul Cercueil wrote:

> Well you only applied patch 6/6, didn't you? I only see this one in your
> tree.

Hrm, yeah.  Wonder what happened there...

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcTSMACgkQJNaLcl1U
h9AVBwf/XcNRXVJiLvl2kUf/fvAw58lzjnm/DVNQ8TfmAVVPX1W+Z6K7OI5mRN53
gZGVCjoYrXtQFmPl/EqxHUWbJQhOzSYx6zmTcfseRtnAYydILR2o4lvwsCeQtVtu
yEooUYy347HhdY+kO1MpoZcBKQqNxxkDAu8m3a7oBBTsrRbB0yNwNZmtXzCeCDRM
kOA0Mak40tROFxnWaw+ityHbmb5avQql04aI3WY9SW3KJ6VdLIiRqapiK61dLo1r
ZKv0MguweBCXTe73yHT+LZy8mPQBpIQzbpdVd+Qbfeb/VHtX0K2WJa0jxkYA6RJ7
jsiuR/EMLoyftspAFl9uwYlJN4K7qQ==
=ZC7V
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
