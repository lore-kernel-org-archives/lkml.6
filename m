Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B65C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8522147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8522147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJFRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 13:42:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51115 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbeJFRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 13:42:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1224211|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D-8QCpe_1538822334;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D-8QCpe_1538822334)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sat, 06 Oct 2018 18:38:54 +0800
Date:   Sat, 6 Oct 2018 18:38:54 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        anurup.m@huawei.com, Jonathan.Cameron@huawei.com,
        will.deacon@arm.com, zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V10 8/8] dt-bindings: timer: gx6605s SOC timer
Message-ID: <20181006103853.GA4149@guoren-Inspiron-7460>
References: <cover.1538672812.git.ren_guo@c-sky.com>
 <6ed886ec014de868e0a84a62e339e45de4ea1e5f.1538672812.git.ren_guo@c-sky.com>
 <20181005202108.GA20389@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005202108.GA20389@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thx for the review.

On Fri, Oct 05, 2018 at 03:21:08PM -0500, Rob Herring wrote:
> On Fri, Oct 05, 2018 at 01:22:28AM +0800, Guo Ren wrote:
> > Dt-bindings doc for gx6605s SOC's system timer.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> 
> Please add acks/reviewed-by's when posting new versions.
Add:
Reviewed-by: Rob Herring <robh@kernel.org>

OK?

Best Regards
 Guo Ren
