Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D841B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D841B20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeFTKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:46:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeFTKqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:46:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 163CE20741; Wed, 20 Jun 2018 12:46:22 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E0C49203B0;
        Wed, 20 Jun 2018 12:46:11 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:46:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-bq4802: add error handling for devm_ioremap
Message-ID: <20180620104612.GC7737@piout.net>
References: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 12:40:03+0800, Zhouyang Jia wrote:
> When devm_ioremap fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling devm_ioremap.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/rtc/rtc-bq4802.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
