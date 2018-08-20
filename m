Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8620C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8D21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8D21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHUC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:57:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54810 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeHUC5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:57:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4954E207B1; Tue, 21 Aug 2018 01:39:20 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1EC0420750;
        Tue, 21 Aug 2018 01:39:10 +0200 (CEST)
Date:   Tue, 21 Aug 2018 01:39:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTC for 4.19
Message-ID: <20180820233909.GY21707@piout.net>
References: <20180820212157.GA20956@piout.net>
 <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwgmjY-RRRsSZTHnzceuYy0ouAishVe934WOjVQ5kdKmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2018 16:34:18-0700, Linus Torvalds wrote:
> On Mon, Aug 20, 2018 at 2:22 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Subsystem:
> >  - struct rtc_task removal along with rtc_irq_register/rtc_irq_unregister
> 
> You can still find stale mentions of it by grepping for it:
> 
>  * @task: currently registered with rtc_irq_register()
> 
> which should presumably be fixed up too.
> 

Ah right, I'll clean that up along with another suggestion from Arnd.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
