Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6ACC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471FB20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471FB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLCKIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55273 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeLCKIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2E90B20CFA; Mon,  3 Dec 2018 11:07:50 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 06D5A20787;
        Mon,  3 Dec 2018 11:07:40 +0100 (CET)
Date:   Mon, 3 Dec 2018 11:07:39 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: Rename dw-i3c-master.c into i3c-master-dw.c
Message-ID: <20181203110739.0959d6c0@bbrezillon>
In-Reply-To: <20181126084514.23663-1-boris.brezillon@bootlin.com>
References: <20181126084514.23663-1-boris.brezillon@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Mon, 26 Nov 2018 09:45:14 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Follow the naming scheme introduced by the Cadence driver to keep things
> consistent.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/i3c/master/Makefile                             | 2 +-
>  drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} (100%)

Any opinion on this rename. If you disagree with this, then I'd like to
know it.

Regards,

Boris

> 
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index fc53939a0bb1..c5f52733aa10 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
> -obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
> +obj-$(CONFIG_DW_I3C_MASTER)		+= i3c-master-dw.o
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/i3c-master-dw.c
> similarity index 100%
> rename from drivers/i3c/master/dw-i3c-master.c
> rename to drivers/i3c/master/i3c-master-dw.c

