Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97ABC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F18020865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F18020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIKMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:37:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37495 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeIKMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:37:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60D22207A8; Tue, 11 Sep 2018 09:39:33 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37CB220703;
        Tue, 11 Sep 2018 09:39:23 +0200 (CEST)
Date:   Tue, 11 Sep 2018 09:39:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jeremy Gebben <jgebben@sweptlaser.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180911073922.GG2494@piout.net>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
 <20180910213654.26059-3-jgebben@sweptlaser.com>
 <20180910232019.GA8439@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910232019.GA8439@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 16:20:19-0700, Guenter Roeck wrote:
> > +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> > +				unsigned int new_timeout)
> 
> I'll leave multi-line alignment issues to the driver maintainer.
> 

Indeed, I'd like those to be aligned on the parenthesis.

Thank you for your review.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
