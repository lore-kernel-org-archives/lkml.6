Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C04C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF221479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DbphoVWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbeIUX3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:29:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44670 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JvDiDNeeCvrvtd+m4PKb8k0vBYUIpsqjMWrMN5GpSI8=; b=DbphoVWuxm7zFiZbE0XB49Sx8
        uyXJKxpizo8pLzcQ6SavUWkwDwxshWUNHIVhMKQgaSo0TDQrQsyoovzmFAUciNWtymFShxrxozKFn
        +ihfuSpwn/v7oVUF/cbQL4/9SsNdOhN+OGk4A3K/2hIlKoGvKVM/00tg5i5dDx9nJgZ+g=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3POS-0000ix-W0; Fri, 21 Sep 2018 17:39:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4B0A9440078; Fri, 21 Sep 2018 18:39:03 +0100 (BST)
Date:   Fri, 21 Sep 2018 10:39:03 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Ryan Case <ryandcase@chromium.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Message-ID: <20180921173903.GH20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 10:30:57AM -0700, Stephen Boyd wrote:
> Quoting Ryan Case (2018-09-20 15:40:54)

> > +Required properties:
> > +- compatible:  Should contain:
> > +               "qcom,sdm845-qspi"

> Does someone have a more generic compatible string that can be added
> here to indicate the type of quad SPI controller this is? I really doubt
> this is a one-off hardware block for the specific SDM845 SoC.=20

The idiom for DT is supposed to be to use only device specific names
unfortunately.

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulLLYACgkQJNaLcl1U
h9AU1wgAgr4OI2IG5x9+yA8va8lXHDVS1UyHUqTHnwCA/kxaU4R7rgH206FRlpJ8
pFUfghnofGabgVNonvWdrWrKMc91J3CDus2GxlK4ABtCd3Lw5DtRhSJGoyNV7Fod
UM/VSpTgicbumfAzBezNumE404xAKGrhD6Q0qsSq9X6wyAaX+GsQXeEquCetMEvq
1DHzxH06iPB4GElxOV3Wvn2qxNeoGyB3biQPharwFIPZ9gAuTz6S4HlPiZ8ZoK0c
g6ltMOlI7lHyWRcEouAS83uxZPpTOy0C9U0zgxd403hVDKB4Fmj7NLKgi2MwAMf4
DnbWiuFULuhhd6jw/6rZbkB3XDKHXQ==
=FO1W
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
