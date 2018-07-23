Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF83ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9139220856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9139220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeGWQlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:41:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:34858 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbeGWQlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:41:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3160A75;
        Mon, 23 Jul 2018 15:39:25 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:39:24 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] mtd: nand: fix spelling in driver api documentation
Message-ID: <20180723093924.04af0e2f@lwn.net>
In-Reply-To: <20180720075334.24254-1-marcel@ziswiler.com>
References: <20180720075334.24254-1-marcel@ziswiler.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 09:53:33 +0200
Marcel Ziswiler <marcel@ziswiler.com> wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes some spelling mistakes.

So I hate to complain about a documentation improvement, but...

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  Documentation/driver-api/mtdnand.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
> index dcd63599f700..c55a6034c397 100644
> --- a/Documentation/driver-api/mtdnand.rst
> +++ b/Documentation/driver-api/mtdnand.rst
> @@ -374,7 +374,7 @@ The nand driver supports three different types of hardware ECC.
>  
>  -  NAND_ECC_HW8_512
>  
> -   Hardware ECC generator providing 6 bytes ECC per 512 byte.
> +   Hardware ECC generator providing 8 bytes ECC per 512 byte.

That's not a spelling mistake, that's a factual change.  I'll apply the
patch since it appears to be correct, but will be tweaking the changelog.

Thanks,

jon
