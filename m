Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B92C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EFF2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EFF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeJDUCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:02:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38099 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeJDUCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:02:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0EF6F20802; Thu,  4 Oct 2018 15:09:18 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id C68E6206A1;
        Thu,  4 Oct 2018 15:09:07 +0200 (CEST)
Date:   Thu, 4 Oct 2018 15:09:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] mtd: physmap_of: Remove unused struct
 of_device_id
Message-ID: <20181004150908.71f9130c@bbrezillon>
In-Reply-To: <20181004130110.8496-2-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
        <20181004130110.8496-2-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Oct 2018 15:01:02 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> This struct does not seem to be used anywhere on the code
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Already queued that one.

> ---
>  drivers/mtd/maps/physmap_of_gemini.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
> index 830b1b7e702b..9df62ca721d5 100644
> --- a/drivers/mtd/maps/physmap_of_gemini.c
> +++ b/drivers/mtd/maps/physmap_of_gemini.c
> @@ -44,11 +44,6 @@
>  
>  #define FLASH_PARALLEL_HIGH_PIN_CNT	(1 << 20)	/* else low pin cnt */
>  
> -static const struct of_device_id syscon_match[] = {
> -	{ .compatible = "cortina,gemini-syscon" },
> -	{ },
> -};
> -
>  int of_flash_probe_gemini(struct platform_device *pdev,
>  			  struct device_node *np,
>  			  struct map_info *map)

