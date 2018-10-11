Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A44C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D52085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Q6SW65/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeJKVzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:55:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rZovQqPnPpsh+zzux/WpkUqSSxiuFtvMuEctjuVaye8=; b=Q6SW65/GyodY6lXddwCVf4DO6
        14e9/a2O9RUlL222T6QikvfDslg8vdEIiocKPEUcpDSyaA75z9mDtk+PFFpN/bQrjm1ocHqWBrHVh
        /iAxRdqxbGAx42gsiHU77hAmcyiWxte7aC/S8C+jj39zJ5CErwTHU+9X4f60OtZivcZac=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAbvs-0001k1-Hw; Thu, 11 Oct 2018 14:27:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ED16311223ED; Thu, 11 Oct 2018 15:27:19 +0100 (BST)
Date:   Thu, 11 Oct 2018 15:27:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20181011142719.GE25351@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-2-lkundrak@v3.sk>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 07:09:26PM +0200, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.

*Way* more.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/XccACgkQJNaLcl1U
h9Dn4wf/dFr/ysMnQUtut+ehLhJxGdV4dMToFsTrQhYDOk2kvEfVrH4FVEYEwiXg
jpE/ZJTn26gJEwdDrCewyvvMzUAC9g9Xhjfv8dOvUCtauA1IDwGu6V/WLSDrQTm9
GbLb2DZPjmxWRHWl1S8DqFXyfgN/21yd5xrblF1xx4vfHklvpyJsCZoQQWaPQ04g
9H+BVnzWXp1KqOPq1Dz0hA3XCLvQcZwDQk/VdYTfrHqvyLDcp0qY4JZRUM8WS/Wx
npjK9MYUE8msSGLgzZV/2y1kYQpby2IOeXYujmpj7lU6YpV1t7yJsKhtrzIkH0Um
NH92EqNJ7lG1qcpDO6gvlcgARDQ4zw==
=RRfV
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
