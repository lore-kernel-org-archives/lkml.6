Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C32077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="l9BiacCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDUSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:18:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIDUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FlRd+M1rk+NPte8qjDr7LfvbSmlTLRzCPQZ1q+YfT4g=; b=l9BiacCOK46u71uxvniJLgnQ4
        cmaKnPuc/aCktl5XhFUvXZEROvkidHFvH6RBhjUPr3xqPDkyzE6x+cjRjudLHsQJMP3mzxH2Jd56T
        O2ueXj7KRtkGlMmJ0DfokA7zpPOfa8mh+nbNhq7+tVDr0+wiXBFHk/qahs5IL4M3u6gOk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxDd1-0001T2-F0; Tue, 04 Sep 2018 15:52:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2449511227D8; Tue,  4 Sep 2018 16:52:31 +0100 (BST)
Date:   Tue, 4 Sep 2018 16:52:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: tlv320aic31xx: Add headphone/headset
 detection
Message-ID: <20180904155231.GI12993@sirena.org.uk>
References: <20180904153619.2199-1-afd@ti.com>
 <20180904153619.2199-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <20180904153619.2199-2-afd@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:36:18AM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This doesn't apply against current code (even -next) - please check and
resend:

$ git am -3 --signoff /tmp/fnord
Applying: ASoC: tlv320aic31xx: Add overflow detection support
Applying: ASoC: tlv320aic31xx: Add headphone/headset detection
error: sha1 information is lacking or useless (sound/soc/codecs/tlv320aic31xx.c).
error: could not build fake ancestor

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOqj4ACgkQJNaLcl1U
h9CxMAf/THZWb0/SH2oJMu2w92+xy94natUzhfHOQ41peMsly/Fzmf18Qt/gvGcp
FryEEJJW9Fq4cqX8UFR2oy5YxdJZT7CuR7POKZ6Cq/TuA7A7fP9LK9tHA1mE5YWP
q3ExUgdxQJ5kRmF50t2lbp95LqZgRK7dXjEtqiLgdo1X2uAyyEkHlnuu/WQ6DxmD
KVmrVFTpai6txY5j46dCamqOn8zsyBFoMLJ69hWdFw5XqJYvcla8c2VKtoleIsZS
aK2RvcGjdRs5epsGkP5gis7DJ7dXkRbt4cpVHu9tg+J6C4Iqjz8v1bU1GE22EdW6
Zc16ylStjAWBlzbDkfZPtpth16XgEA==
=ONEw
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
