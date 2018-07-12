Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D819EB8EF5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1379620846
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1379620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeGLSo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:44:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeGLSo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:44:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28ECD20798; Thu, 12 Jul 2018 20:33:42 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id F2FE0206ED;
        Thu, 12 Jul 2018 20:33:41 +0200 (CEST)
Date:   Thu, 12 Jul 2018 20:33:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/4] rtc: omap: fixes and clean ups
Message-ID: <20180712183342.GH16084@piout.net>
References: <20180704090558.16647-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 11:05:54+0200, Johan Hovold wrote:
> Here are a couple of fixes for issues discovered through inspection
> along with some clean ups.
> 
> Johan
> 
> 
> Johan Hovold (4):
>   rtc: omap: fix potential crash on power off
>   rtc: omap: fix resource leak in registration error path
>   rtc: omap: add missing register lock in error path
>   rtc: omap: drop unnecessary register unlock around reads
> 
>  drivers/rtc/rtc-omap.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 

All applied, thanks

> -- 
> 2.18.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
