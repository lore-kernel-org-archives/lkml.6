Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A99C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589B720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN8dTZVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589B720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeFTVfZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933285AbeFTVfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:23 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EC32083A;
        Wed, 20 Jun 2018 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529530523;
        bh=VmeS3cp0iW/LzNAJELkosgq7Pgj07zg2rrjVSEGyHkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN8dTZVBhpzO3OzYq+IR9UQqqHcHmch51Y0DEkvSce5NPEEsg2gDNsogtyadf/sPx
         LLffuYPQN9iqY3v1X8eIysaiHnfbRbB+GPvBjdryR4zGY1dg3DvciaHiSfaB+wV9Ra
         tdkXLD+mpFZ71VXSI75nDBp2I4q9s2V0+fZ5bpUU=
Date:   Wed, 20 Jun 2018 22:35:19 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: mscc: build FIT image for Ocelot
Message-ID: <20180620213518.GC22606@jamesdev>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 25, 2018 at 11:16:06PM +0200, Alexandre Belloni wrote:
> +config FIT_IMAGE_FDT_OCELOT_PCB123
> +	bool "Include FDT for Microsemi Ocelot PCB123"
> +	select MSCC_OCELOT
> +	help
> +	  Enable this to include the FDT for the Ocelot PCB123 platform
> +	  from Microsemi in the FIT kernel image.
> +	  This require u-boot on the platform.

nit: s/require/requires/

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyrIlgAKCRA1zuSGKxAj
8g1GAP9Vks506o7RiTuEOxZk0KT4ieio5219M8qOXbdI4R/oDQD9E38xNMnjOE+e
rQLqP+NZxeOzWr3m4rXpf3+r7orYuQw=
=i+eZ
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
