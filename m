Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2FEECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F001B21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F001B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJRKjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:39:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46024 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbeJRKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:39:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09739736|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.D3j-VaZ_1539830450;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3j-VaZ_1539830450)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 18 Oct 2018 10:40:50 +0800
Date:   Thu, 18 Oct 2018 10:40:50 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Message-ID: <20181018024049.GB13314@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a2x_ECC0bjYGUHm5mO9KrWviyWg8xVWNqXkSeNmpjdDxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2x_ECC0bjYGUHm5mO9KrWviyWg8xVWNqXkSeNmpjdDxA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:17:05PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds atomic, cmpxchg, spinlock files.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> I'd wait for Peter to give his final Ack here.
Yes, Peter help a lot to improve the patch.

Best Regards
 Guo Ren
