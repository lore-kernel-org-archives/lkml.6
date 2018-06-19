Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67012C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369320652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hCHoHDA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1369320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966575AbeFSPPZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:15:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51152 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966451AbeFSPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EBZ5V7ApmFkeJ3RMs1nUNKSgYZA5r7pv9Yi+iN4nOOA=; b=hCHoHDA/AZo38B0EJRxM5jjMU
        J9GmjADzg3CXJTT+qAKqL94GrszX2nadmKzzolVRZOuQRaidyn2FtZCKSq6ki1VmsWPJaDT8WGQmn
        Q1aOBsp6doBtjT3j2TQ3G2nzKUqMYIRBc20m2XtAVacNMCpRwJhYqk6Ibj/67I5LUN02U=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVILa-0001Kh-Mq; Tue, 19 Jun 2018 15:15:06 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVILa-0001qZ-5E; Tue, 19 Jun 2018 16:15:06 +0100
Date:   Tue, 19 Jun 2018 16:15:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180619151506.GG11230@sirena.org.uk>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
In-Reply-To: <20180618162124.21749-2-bugalski.piotr@gmail.com>
X-Cookie: If you suspect a man, don't employ him.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 18, 2018 at 06:21:23PM +0200, Piotr Bugalski wrote:

> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}

If this can be empty should we adjust the callers to allow it to just be
omitted?

> +static int atmel_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
> +	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
> +
> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	clk_disable_unprepare(aq->clk);
> +
> +	spi_unregister_controller(ctrl);
> +
> +	return 0;
> +}

You should unregister the controller before disabling the hardware,
otherwise something could come in and try to start an operation on the
controller (or already be running one) while the hardware is disabled
which might blow up.

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlspHfkACgkQJNaLcl1U
h9Cymgf+MbrO5iP90HOZ4RRfuC7+k40zc4d09EiG7izyzvJ2/tYUEuSN13tnVCnS
kLf/EzOTei8n+cWU4jsetP27cVnhFSwAWAlnFQFYtd7yUV/e9bkoLIhuNTPs8RA7
pDtsc8bwrYqfxq0G/KoH2kUqa60fFnCRxxRkcTkaldu7oKe8m4i8pEdYVp52CSkl
1KHxfemgHnx40BFB9Aw2jS1UR5S812PVth6m9XV+qwphuUvlSkquORFe0uv0rNum
4AOK+w4QXvcZp/B9W1nEcwcsccDBJ082oMsI/kUj1rbCy7DlE8gI2OHufN9AlM/R
UXvlT50vdrssQaiicBHXd8Riqf18CA==
=2QLs
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
