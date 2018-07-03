Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD14C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFCD24A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RrBhBAkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFCD24A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933620AbeGCPll (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:41:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGCPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MnMaN9IJ+ukQABWKaTVLG9TZke7Q80WM7/fqWMQ81QU=; b=RrBhBAkpZJKQIMKM7u61towhg
        oBONCMBJXnsIrbOcYPyO6Wg5M7LHuPGHeIsF4rJZpp0bPFcfQnvU1hXN+szjUkC7R49WLVJGdANbe
        Y8gepbVqUsjAo+M/ngmrzS0rwZhAUd36R6Q40W6rJIossjgk+33W1wFprV6stI/SrW1j0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNQw-0006CN-7E; Tue, 03 Jul 2018 15:41:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNQv-0004Ue-QD; Tue, 03 Jul 2018 16:41:37 +0100
Date:   Tue, 3 Jul 2018 16:41:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
Message-ID: <20180703154137.GD13744@sirena.org.uk>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
 <20180703153212.GC13744@sirena.org.uk>
 <1530632179.2900.210.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <1530632179.2900.210.camel@baylibre.com>
X-Cookie: Dental health is next to mental health.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2018 at 05:36:19PM +0200, Jerome Brunet wrote:

> Unless I missed something, which entirely possible, I don't think any patches of
> this series have been applied yet. You asked me resubmit after the v1 because of
>  power supply bindings and the mode selection.

> I don't see anything related to the es7241 in your tree ATM.

Oh, my mistake sorry - I must have copied it into my to apply queue
twice so got a reject on the second application.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7mTEACgkQJNaLcl1U
h9Cg4Qf+IurQYHlKjiyrGyi4+0B7ZFkGo5+aiNzWmnSYD8sZaI3RVFO6r+RpAde9
9ZRlTjjZu1PptsicEdOOdqvGP1Mn1J7sThMmd0nHMG7ePnZu2iWC+OU+2/D+IXTG
/axsgn+iRuTp5lvDM9lVeyV+IOhjh/8fxhMYihxCDovm0xD67YlkbRXj9mvYtUFL
z3LBpj9n63nfLmb3YnFFBtBsMXbJ4na+sANErQsC94PjIXHikxhJTQ6GRmqW9kSq
fo1ktpAE4N8KaLpjSUPGZyves5Ld2lOnudRHRpE1/8CMX/3b0m8G33pK2rV05OyT
NSa6y/IxU2K0fB3lDTfO2LtIWjN/JQ==
=t6Mw
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
