Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE005C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890AC20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890AC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJ3Uo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:44:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13125
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbeJ3UoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:44:25 -0400
X-IronPort-AV: E=Sophos;i="5.54,444,1534802400"; 
   d="scan'208";a="283816062"
Received: from unknown (HELO function) ([193.50.110.184])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2018 12:51:13 +0100
Received: from samy by function with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gHSYD-0004Io-2O; Tue, 30 Oct 2018 12:51:13 +0100
Date:   Tue, 30 Oct 2018 12:51:13 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin King <colin.king@canonical.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: clean up few indentation issues
Message-ID: <20181030115113.pbef3nmx5t4beygk@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181030110959.1471-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030110959.1471-1-colin.king@canonical.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King, le mar. 30 oct. 2018 11:09:59 +0000, a ecrit:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up indentation issues across the driver
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/kobjects.c      | 2 +-
>  drivers/staging/speakup/speakup_decpc.c | 6 +++---
>  drivers/staging/speakup/speakup_keypc.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
> index 08f11cc17371..2e36d872662c 100644
> --- a/drivers/staging/speakup/kobjects.c
> +++ b/drivers/staging/speakup/kobjects.c
> @@ -545,7 +545,7 @@ ssize_t spk_var_show(struct kobject *kobj, struct kobj_attribute *attr,
>  	int rv = 0;
>  	struct st_var_header *param;
>  	struct var_t *var;
> -		char *cp1;
> +	char *cp1;
>  	char *cp;
>  	char ch;
>  	unsigned long flags;
> diff --git a/drivers/staging/speakup/speakup_decpc.c b/drivers/staging/speakup/speakup_decpc.c
> index 6649309e0342..459ee0c0bd57 100644
> --- a/drivers/staging/speakup/speakup_decpc.c
> +++ b/drivers/staging/speakup/speakup_decpc.c
> @@ -302,12 +302,12 @@ static void synth_flush(struct spk_synth *synth)
>  	while (dt_ctrl(CTRL_flush)) {
>  		if (--timeout == 0)
>  			break;
> -udelay(50);
> +		udelay(50);
>  	}
>  	for (timeout = 0; timeout < 10; timeout++) {
>  		if (dt_waitbit(STAT_dma_ready))
>  			break;
> -udelay(50);
> +		udelay(50);
>  	}
>  	outb_p(DMA_sync, speakup_info.port_tts + 4);
>  	outb_p(0, speakup_info.port_tts + 4);
> @@ -315,7 +315,7 @@ udelay(50);
>  	for (timeout = 0; timeout < 10; timeout++) {
>  		if (!(dt_getstatus() & STAT_flushing))
>  			break;
> -udelay(50);
> +		udelay(50);
>  	}
>  	dma_state = dt_getstatus() & STAT_dma_state;
>  	dma_state ^= STAT_dma_state;
> diff --git a/drivers/staging/speakup/speakup_keypc.c b/drivers/staging/speakup/speakup_keypc.c
> index 3901734982a4..b788272da4f9 100644
> --- a/drivers/staging/speakup/speakup_keypc.c
> +++ b/drivers/staging/speakup/speakup_keypc.c
> @@ -177,7 +177,7 @@ static void do_catch_up(struct spk_synth *synth)
>  	jiffy_delta = spk_get_var(JIFFY);
>  	delay_time = spk_get_var(DELAY);
>  	full_time = spk_get_var(FULL);
> -spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	spin_lock_irqsave(&speakup_info.spinlock, flags);
>  	jiffy_delta_val = jiffy_delta->u.n.value;
>  	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  
> -- 
> 2.19.1
> 

-- 
Samuel
<P> je sens venir la fonte 14 pour le rapport
 -+- #ens-mim -+-
