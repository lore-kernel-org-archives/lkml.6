Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5613EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132752082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IplMn5CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132752082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJDRnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:43:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJDRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oCwKq3koAt9EVrwAvlJ8K1HOKiRI20kWtt/9MIcEsz4=; b=IplMn5CE0D5qixjS4aGIEYj8P
        DLH/ROm6U6aQrxH09pvggTDYbjA875Xeo7x5xYUcK1bn/uff2OKMgABEYPTlQ2JgMwSd52keywcEJ
        ZSFcuV4tmGeogmnXYfAjrIV93NC1IkaQ2tOL1zg9Tmdx4TRPyX/7gShrUTWbR1K87gWb0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g81DE-0008IJ-A6; Thu, 04 Oct 2018 10:50:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E1F311121BA8; Thu,  4 Oct 2018 11:50:31 +0100 (BST)
Date:   Thu, 4 Oct 2018 11:50:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>, robh@kernel.org
Subject: Re: [PATCH] regulator: fixed: Use more standard GPIO binding
Message-ID: <20181004105031.GD6412@sirena.org.uk>
References: <20181004090654.32233-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20181004090654.32233-1-linus.walleij@linaro.org>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 11:06:54AM +0200, Linus Walleij wrote:

>  Optional properties:
> -- gpio: gpio to use for enable control
> +- gpios: gpio to use for enable control

Are we supposed to be able to have just plain gpios as a standards
conforming property or would best practice be to call it enable-gpios or
something?

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu18HcACgkQJNaLcl1U
h9DrPwf7Bh2tYKRDE9uZ3rdDUFBuNurCRgtWm7BsUaccxX5NvLnJJ5GNK310VNxl
qVh5M96vfWmoylOBi2ETFo0wtOXMIwNyVeWXfvPJNhCZnVLZuBtITDN5zAJPqlAX
mgb0mWp0w/IuQ8OSlHwrd7HioG0k/8RPPrQ0A0SmVXWuKgIKDsS2MZaqKLA6vkVF
bsWOx4FqX7IiCyduFC12baqFxtrKCrhTkEkYCKVxaNZ88tn/mqqwqt3fHush550w
wI9Ek7j/lSVMbHKTj0jA6eVs1bNYgqY1qfRJKafKQv446Yy2nK85xF6vTFMqYQFs
Muo4xvKIzBM88b8sw0HqigGKMkjfRA==
=Nkv4
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
