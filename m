Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50830C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6E214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HeRqtb8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A6E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeIRVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:15:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeIRVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDaNfd0rgrSo7sZRcBTvSl0AUK6UOsgDou3ekTN0U/8=; b=HeRqtb8JVSgc99zdaS2XbY2kB
        NHeqHUd6iyx61PmKqgzSAKSgWEH9jFkFJYWUMThjvxFvVq6/cUH9Zc4P3yVxu0xaYdER8e67Lpl2O
        uwptZ1mxDWv7wdVwKwAnhwzWKMlbrbTGrVxJZgmZf5Bnneam+dlmR8FNgAGtDKyykVkAk=;
Received: from [209.82.80.116] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2I8f-0003MG-Qw; Tue, 18 Sep 2018 15:42:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 793D3440078; Tue, 18 Sep 2018 16:42:07 +0100 (BST)
Date:   Tue, 18 Sep 2018 08:42:07 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20180918154207.GJ2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
 <20180917175753.GE2471@sirena.org.uk>
 <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 18, 2018 at 02:15:12PM +0200, Lubomir Rintel wrote:

> Should I've Cc'd everyone on the full series, even if only a patch or
> two might be really interesting to them? How do I decide whether the

It's a judgement call about who gets the patches but in general it's
good to either do that or make sure that everyone sees the cover letter
which explains what the whole series is.

> recipient needs to be in the commit's commit message (as opposed to
> just --cc on a command line)?

Using CCs in the commit message is entirely optional TBH - a lot of
people just don't do it at all, often when it is done it's a list of
everyone who got the mail.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhHM4ACgkQJNaLcl1U
h9Cezwf5AfaAGyXR47c4q3qjI8ELdyasWL5tIcpl3Qhd6YeLW6GBKyhlOl2Cu/Ey
ZXO1TLEnOy35eFKL2Wh2YHsxMgHb4fPy3kA2alWhRgzURgKR68ywzOIO+IlvAGLQ
Wh6Mj8BCKYk0E338mZ0VJWTqJxx4dmXoXU2d18G2FnO5ix5ukNOaKEhHwkl610Dd
pIkrHio8u82+xQ1TQ/KhEbEw3WoqvWY9Z6a9qd2dbevhLQei3zTS4Bj6SdHxDqrR
YHZQvQPdh5CuLpvFKOPClF+Gjep6SoWb+M3CAGKmlhO7mwqYG0gqms88QeEsQnbx
4NjHfimOKlW88L02ntofOFnTwBg+jQ==
=FDO6
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
