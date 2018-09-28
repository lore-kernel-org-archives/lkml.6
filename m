Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8882152F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8882152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeI1Sfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:35:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57085 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1Sft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:35:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 77B28206FF; Fri, 28 Sep 2018 14:12:18 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4F2A6206A7;
        Fri, 28 Sep 2018 14:12:18 +0200 (CEST)
Date:   Fri, 28 Sep 2018 14:12:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: isl1208: access i2c client via rtc parent
Message-ID: <20180928121219.GS16644@piout.net>
References: <20180928114832.27383-1-Denis.Osterland@diehl.com>
 <20180928120451.GR16644@piout.net>
 <1538136387.6162.10.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538136387.6162.10.camel@diehl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2018 12:06:27+0000, Denis OSTERLAND wrote:
> Am Freitag, den 28.09.2018, 14:04 +0200 schrieb Alexandre Belloni:
> > Hello,
> > 
> > Oh right, I actually had that but somehow, I stashed the patch instead
> > of squashing it.
> > 
> > If that is fine for you, I'll fold that in the original patch (I'll ad
> > your SoB).
> > 
> > 
> Sounds good.
> 

Thanks again !


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
