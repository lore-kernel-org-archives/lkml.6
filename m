Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD53EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDE622467
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDE622467
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeGDL63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:58:29 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50055 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933596AbeGDL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:58:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1854773|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CMCZ.-n_1530705497;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CMCZ.-n_1530705497)
          by smtp.aliyun-inc.com(10.147.42.16);
          Wed, 04 Jul 2018 19:58:17 +0800
Date:   Wed, 4 Jul 2018 19:58:17 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Message-ID: <20180704115817.GA24372@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
 <20180704050822.GA23536@guoren>
 <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 08:43:29AM +0200, Thomas Gleixner wrote:
> > Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
> > one file eg: irq-csky.c? 
> 
> Yes, but only if there is enough code to share without creating an ifdef
> mess. But that looks doable
Ok, I'll try.

 Guo Ren
