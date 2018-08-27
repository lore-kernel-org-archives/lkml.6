Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC6208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC6208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH0V42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:56:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0V42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:56:28 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73530CB6;
        Mon, 27 Aug 2018 18:08:49 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:49:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abishek V Ashok <abishekvashok@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ddk750_mode.c: Wraps line to 80 charecters
Message-ID: <20180827174940.GC27089@kroah.com>
References: <20180808093552.2248-1-abishekvashok@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808093552.2248-1-abishekvashok@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:05:52PM +0530, Abishek V Ashok wrote:
> Splits definition of function programModeRegisters into two lines such
> that each line is less than 80 characters.
> 
> Signed-off-by: Abishek V Ashok <abishekvashok@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 7e22d093b..57cf9e6a5 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -13,8 +13,8 @@
>   * HW only supports 7 predefined pixel clocks, and clock select is
>   * in bit 29:27 of Display Control register.
>   */
> -static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> -						  unsigned long dispControl)
> +static unsigned long displayControlAdjust_SM750LE(
> +		struct mode_parameter *pModeParam, unsigned long dispControl)

Ick, actually the original code is just fine here, please leave it
as-is.

thanks,,

greg k-h
