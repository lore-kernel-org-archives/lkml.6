Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C08B2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C08B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeGLT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:29:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40794 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeGLT3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:29:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E70820719; Thu, 12 Jul 2018 21:18:07 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62D7E20012;
        Thu, 12 Jul 2018 21:18:07 +0200 (CEST)
Date:   Thu, 12 Jul 2018 21:18:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: m48t59: remove redundant pointer 'name'
Message-ID: <20180712191807.GK16084@piout.net>
References: <20180711083312.5483-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711083312.5483-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 09:33:12+0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'name' is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'name' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-m48t59.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
