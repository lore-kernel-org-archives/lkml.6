Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16935C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2898208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="S1OXL3+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2898208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbeHATaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:30:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389752AbeHATO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/zaiAw8IkCGlb8YxbaQKat50h65a0PCYWBZpyCaG9ow=; b=S1OXL3+ago16oV1ivXO+XX0fv
        BLihU9t9AcPVYeG42IeuvAveBXW1I1l5/1U/BqaQPcEXg901T3tlYlPN5mbhXswKR2oEi/yt5usbi
        g3RFfyMu1iNGx4MooLMnNPN627+6mg+CFRCOL+97onZNdCgsRkQDIyQOx4mLD3ccwqZhQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkuua-00015T-3c; Wed, 01 Aug 2018 17:27:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BB63A1124241; Wed,  1 Aug 2018 18:27:47 +0100 (BST)
Date:   Wed, 1 Aug 2018 18:27:47 +0100
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
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180801172747.GJ5509@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <20180627131609.13681-6-bugalski.piotr@gmail.com>
X-Cookie: You are as I am with You.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 03:16:08PM +0200, Piotr Bugalski wrote:
> Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
> New spi-mem interface allows usage also other memory types, especially
> much larger NAND with SPI interface. This driver works as SPI controller
> and is not related to MTD, however can work with NAND-flash or other
> peripherals using spi-mem interface.

This is fine from a SPI point of view but I'd like to apply it directly
to the SPI tree rather than ack it for merge via the MTD tree - can we
work something out with a shared branch or something?

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlth7ZIACgkQJNaLcl1U
h9DoyAf/axay4apJ06n4JCgJFvYwhcy//Lc98dvXcnht+N+o7q386hp2kgdobQQ6
DEtlMemWfYGAC+SKbOzlk81q5JL/+mP252rjCii5W9moO3Qm2TzCgKtjeWoH3/Va
cjIdVv0j1AeIuMK2H8I3jFOIh0W5ehXJsuNCwN6kf6E4/4w135XlQ7xOaA7hUjrW
UoqWfSkVkYLSHIMnUd7t2q5YVEKf3EoqYc/ddACPX1hwdTm3bE3KuWIwNyMomV1t
e1LAyQ6hMO5ZCU6+/8zjEw2avKuUUEQZRTiBBVyuk2zC1kTg+ARtYg6CbqD96r5J
p80N/6kIUIqOyajvbcgkUjZZCWpeow==
=Xusq
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
