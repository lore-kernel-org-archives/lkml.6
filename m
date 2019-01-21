Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D44C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6056E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAUIOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:14:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:33112 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfAUIOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:14:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0096BAB9;
        Mon, 21 Jan 2019 02:18:12 +0000 (UTC)
Date:   Sun, 20 Jan 2019 19:18:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: DMA-API: fix two typos
Message-ID: <20190120191808.3570ca8f@lwn.net>
In-Reply-To: <1547818702-40035-1-git-send-email-clabbe@baylibre.com>
References: <1547818702-40035-1-git-send-email-clabbe@baylibre.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 13:38:22 +0000
Corentin Labbe <clabbe@baylibre.com> wrote:

> This patch fixes two typos, a missing "e" and dma-api/driver_filter was
> incorrectly typed dma-api/driver-filter.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

So I've applied this, but...

>  Documentation/DMA-API.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
> index 78114ee63057..bd009f3069f8 100644
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -531,7 +531,7 @@ that simply cannot make consistent memory.
>  		       dma_addr_t dma_handle, unsigned long attrs)
>  
>  Free memory allocated by the dma_alloc_attrs().  All parameters common
> -parameters must identical to those otherwise passed to dma_fre_coherent,
> +parameters must identical to those otherwise passed to dma_free_coherent,

That sentence clearly needs a lot more help than just an extra "e"; I
took the liberty of fixing it up on the way in.

Thanks,

jon
