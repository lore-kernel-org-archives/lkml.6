Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CAECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC621508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dSrDHQAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEC621508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeIRVsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:48:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1YC6JztbfBD+Uy/BFjIsDwwZmRR6wdDEqg65M3ZD174=; b=dSrDHQAvs4dPP8bzVv/oO9ZF1
        DJCYnXkxOXAKuc2cTqJ0Sf1c2EK7k0zmqYsNkFkSgbKK3MjBDIMpbJPWahnDNe0E03fhQ2wOwciuT
        +8rNHn+NUOIxA9Qzb2alonzuFbxXeMsoslApFYr7cLh2K5L3Vul2EFSSJjzooRiUcrNUs=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2IeZ-0003Pn-4d; Tue, 18 Sep 2018 16:15:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 056D7440078; Tue, 18 Sep 2018 17:15:04 +0100 (BST)
Date:   Tue, 18 Sep 2018 09:15:04 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Peter Shih <pihsun@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] spi: mediatek: Don't modify spi_transfer when
 transfer.
Message-ID: <20180918161504.GM2471@sirena.org.uk>
References: <20180910035047.98496-1-pihsun@chromium.org>
 <20180910035421.101505-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline
In-Reply-To: <20180910035421.101505-1-pihsun@chromium.org>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 10, 2018 at 11:54:21AM +0800, Peter Shih wrote:

> Change-Id: I23e218cd964f16c0b2b26127d4a5ca6529867673

Please don't include noise like this in upstream submissions, it doesn't
mean anything outside of your company's systems.

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhJIgACgkQJNaLcl1U
h9BaDQf+Nu9Kez1693p1wvOqM7SkP+JhsdZZgbssDubRZnAi8zcLhfhvpvwHAqzx
Sl6khg6e8k+yLmDVXpCHrL+v3bZ8184YojoFaedC0qzjquvtfW/uQlSin2hskErK
x59vldjUwxjhgmFVPK4kd9miy/BU2B8STMqeLswcVs/Apleprw6WGHnlS3JcTLX1
fN+lE+CGGdJrQ1z9/g6aFoVYkEpSO1SXkwfdCyeVvmeLGqkjOD9AARgqnYmBF0x/
rV+OXv0UgVQl1I4U4XsdBd4wmjZGb6sp6SdJ4+oJLLLCiytolnR2oS6qcXkFqYQu
12fYNnjiMOAA7KaNrf5DLwGmIbtGaQ==
=rqUc
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
