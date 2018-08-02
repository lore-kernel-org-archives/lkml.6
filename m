Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31B2151C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31B2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbeHBPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:00:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49027 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387421AbeHBPAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:00:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE2852074F; Thu,  2 Aug 2018 15:09:44 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7E46220719;
        Thu,  2 Aug 2018 15:09:44 +0200 (CEST)
Date:   Thu, 2 Aug 2018 15:09:45 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: spi-mem: Fix a typo in the documentation of
 struct spi_mem
Message-ID: <20180802150945.44cc8328@bbrezillon>
In-Reply-To: <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
        <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 14:53:52 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

We usually try to avoid empty commit message, even if this one is
pretty obvious, I'd suggest adding something here.

"
Fix a typo in the @drvpriv description.
"

?

> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  include/linux/spi/spi-mem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 4fa34a2..72cc9bc 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -124,7 +124,7 @@ struct spi_mem_op {
>  /**
>   * struct spi_mem - describes a SPI memory device
>   * @spi: the underlying SPI device
> - * @drvpriv: spi_mem_drviver private data
> + * @drvpriv: spi_mem_driver private data
>   *
>   * Extra information that describe the SPI memory device and may be needed by
>   * the controller to properly handle this device should be placed here.

