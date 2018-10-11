Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1920652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cBrT+K2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeJKVLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:11:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJKVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hlFF1SoNbToc1IsiuhUFF7C6g3635TjeNR6uS1GNEUQ=; b=cBrT+K2LcWEH+g4qSRiyYcOdr
        acP0R7gHSN1JexVPCtNMF7/wpE4NWh485F9AFrOnucLHnHk+UUFGBdQ2CjWMXXL67tGqnKpYtp5Nj
        PI6tZjlXnXy/hjAnaY/R4vROggja2EWJNb2GpmVgFER3K8QcJ4gLx7Vdg3n4ew28D51XE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAbGE-0001gK-3m; Thu, 11 Oct 2018 13:44:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ACB6511223ED; Thu, 11 Oct 2018 14:44:17 +0100 (BST)
Date:   Thu, 11 Oct 2018 14:44:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonnyc@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add compatible for Amazon's
 Alpine spi controller
Message-ID: <20181011134417.GB25351@sirena.org.uk>
References: <1539209339.1944.23.camel@impinj.com>
 <1539256807-25676-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1539256807-25676-1-git-send-email-talel@amazon.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 02:20:06PM +0300, Talel Shenhar wrote:
> This compatible adds the ability for dw spi controller driver to work with
> the dw spi controller found on Alpine chips.

Please don't send new series in reply to old ones, especially if you're
not versioning things, as it makes it much harder to track what's going
on.

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/U7AACgkQJNaLcl1U
h9B1FAf/UEZhYQp8Zgcy6+SmQ4J9n+gBAW74rqwmv8XSvtrPqPVkfBHa3YK8ly3O
jTyAq0H7Htc49FnsMRGHlAFcZ/3A2kmTtWFqsSo7X7nD6pheQ/sfRuDHgpXS7fE8
WdE6s042x/RopPDmrrC0HeGG6Oi5m/MgDIBoNDtfALGX61dIvDD1MCTAsS6cWb8i
FKHrlHyE98daaxBr3i5RjWtU2GrM5olIcroCeQknmloxEW2aiA6E82MyhN8ZrQSf
HzQldqSCK+7nMhj4R4a1fI+u78dPp1PsjFhaafdiRN82emhhkG5XL0Sze3/JxGkv
NzDX8yvxAsqK25Wv+rPfvoosXR9pQw==
=w0Nx
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
