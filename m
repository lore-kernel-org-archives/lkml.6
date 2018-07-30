Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FFF20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Px+rRGJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FFF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeG3Lrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:47:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeG3Lri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DNqgR6YlqHvlfAP68hq7Jq6faT2MolT1cR77uN3seHo=; b=Px+rRGJ0UuXp5aPhD5RxagZU4
        g/ICnkiHcVlclVDMdp1lfxJzUJJ7U8U9BxBUOl/sX8s3oXAQMcaaTR+g6Y14BD3ha/KbVjfguVWqt
        s2n0cNCBrJS/nz6K9se71rh6sFoCW6Pud7HDZaaP+tCDH3yxPpwZRGCWCWP2gxbCnK444=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5Az-0004ui-Je; Mon, 30 Jul 2018 10:13:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5720C1124216; Mon, 30 Jul 2018 11:13:17 +0100 (BST)
Date:   Mon, 30 Jul 2018 11:13:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: spi: snps,dw-apb-ssi: document
 Microsemi integration
Message-ID: <20180730101317.GE5789@sirena.org.uk>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
 <20180727195358.23336-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20180727195358.23336-3-alexandre.belloni@bootlin.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 09:53:55PM +0200, Alexandre Belloni wrote:

> +- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> +- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> +  register set is required (named ICPU_CFG:SPI_MST)

What are valid values for "<soc>"?

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte5LwACgkQJNaLcl1U
h9D31Af+MTQt/If39raq/xaFIc+F56f3Vh/tIl0YPba6fqwho2FURFiu124R/KMQ
U8N7eCxWjkcv2fT2Rv4GAmA3j5h44WBTdYY25rYR8Vp5b0p4yVduaXV63+CPTnjj
F+KhF7Wk0S28pEBKadLHYp33ed1VLtGS5lYga7g5JNXnjlppduKJxLIsppxa4XdB
9/eVJRhwELHqjucdZpx0smhhFKAr8i+jqKud0bjEy9PeUYcS/G41HaSalqBgHYsd
H8oHP1lx8odzkm7QR4eGHDRODw9pi2Lxpa0AAM6Chy3cYr2lLrQpbiRJKdN4Clt0
McOTx22z2AuJs1EQc8U+pt4lPeWKeg==
=rfC2
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
