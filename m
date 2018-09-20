Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5F20676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C5F20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeITLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:36:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55113 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731260AbeITLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:36:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1715617|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.CtHcDMw_1537422880;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtHcDMw_1537422880)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 20 Sep 2018 13:54:40 +0800
Date:   Thu, 20 Sep 2018 13:54:40 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com
Subject: Re: [PATCH V8 5/6] clocksource: add C-SKY SMP timer
Message-ID: <20180920055439.GA5488@guoren-Inspiron-7460>
References: <cover.1537417413.git.ren_guo@c-sky.com>
 <81ffeff6131882989652a0050e5a947ffc9a327c.1537417413.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ffeff6131882989652a0050e5a947ffc9a327c.1537417413.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:39:31PM +0800, Guo Ren wrote:
> +struct clocksource csky_clocksource = {
> +	.name	= "csky",
> +	.rating	= 400,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read	= clksrc_read,
> +};
> +
> +#define CPUHP_AP_CSKY_TIMER_STARTING CPUHP_AP_RISCV_TIMER_STARTING
My fault, forget delete the line above.

 Guo Ren
