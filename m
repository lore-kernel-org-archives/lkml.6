Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE6F2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Iu+dWg7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE6F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeKHVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:43:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zVJ2Y0AtvgPQUsbVb6f/jyH7d+yGby84wCoORZBqF94=; b=Iu+dWg7tWr0vMhUH+P4Z7dnEJ
        1tfH79Q1MpP7BbgcuuSnZ1yZyITnBcS6WJ+/lc7E+TV2ad4MxFMmslMPnegcfqOB4TEAFYeTg/uqB
        UmfcFXA1uM/iwsMBIeH5wUkGR/gxJaUJGlfM2rIqNMiLVt55ec0V5NRRb92OVMVmfc+fM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKj6H-0008Hw-6N; Thu, 08 Nov 2018 12:07:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CAA081124E16; Thu,  8 Nov 2018 12:07:52 +0000 (GMT)
Date:   Thu, 8 Nov 2018 12:07:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
Message-ID: <20181108120752.GC6675@sirena.org.uk>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
 <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
 <20181107151836.GB6809@sirena.org.uk>
 <20181108095022.66ad3ad1@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20181108095022.66ad3ad1@bbrezillon>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 09:50:22AM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Sorry, I got confused about which patch series Boris had asked me to
> > apply for him - it wasn't this one!  Since the review looked like it was
> > just one minor issue last time I'll just leave them for now, they were
> > applied on a separate branch for sharing with the MTD tree so it's easy
> > for me to drop them if that's required or if I should put together the
> > pull request for MTD.  Sorry for any confusion this ends up causing,
> > it's entirely my mistake.

> I'm probably missing something, but I don't see where you made a
> mistake :-). It's indeed the series I asked you to merge, the only
> comment I had was actually a suggestion to help Piotr solve his perf
> issue (which was already present in the old driver).

Oh, OK.  Then we can definitively say I'm confused then :)

> And thanks for creating the mtd topic branch BTW.

Here's a signed tag for just the MTD bits:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mtd-atmel

for you to fetch changes up to 6ca622c87149a20a47abbb954f896f515e2292a7:

  mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver (2018-11-07 13:21:10 +0000)

----------------------------------------------------------------
mtd: Atmel QuadSPI changes for MTD

These changes are dependencies for a branch merged into the SPI tree,
create a signed tag to share them with the MTD tree.

----------------------------------------------------------------
Piotr Bugalski (4):
      mtd: spi-nor: atmel-quaspi: Typo fix
      mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
      mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver
      mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver

 drivers/mtd/spi-nor/atmel-quadspi.c | 528 ++++++++++--------------------------
 1 file changed, 148 insertions(+), 380 deletions(-)

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkJxgACgkQJNaLcl1U
h9BcJgf+NBCkwqCGZqSr7hUTakUsHoRWEPxfsKxf2iq4IXSlsq9ilM+d/TwJXXjf
YQLK9WPUFg2xKylbtQscBOgt49oVGP+cCywuEWrnO32Ix5by1e9BGRFt1n2scsBT
LyAlHyJaQr4HAagkp2F2AZjoBrXq5nRinpYSAjSfRWfL3fFl/9JIScVg+RPxraqW
SZT8C87kQRLcU7AIIij0Q5kSuHthsunFv5tz6DFRILgDMbB5/e4BXwIHbULFj0aq
dIBjhVMkCyhq+MJtief7hTLcO/VGVyCh1tPW449+y6UiSWh1X6bh/t9HHKYAov/e
zZrrK+gCRC9BfrVwEvDZ5ycn4koNOQ==
=C77L
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
