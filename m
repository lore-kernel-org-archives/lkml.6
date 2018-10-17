Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F0C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B0F214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0F214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJQJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:48:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47066 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbeJQJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:48:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09352386|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.D36ymKs_1539741312;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D36ymKs_1539741312)
          by smtp.aliyun-inc.com(10.147.42.197);
          Wed, 17 Oct 2018 09:55:12 +0800
Date:   Wed, 17 Oct 2018 09:55:12 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, jhogan@kernel.org, paul.burton@mips.com,
        peterz@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V13 0/4] C-SKY(csky) Linux Intc Driver
Message-ID: <20181017015511.GA21519@guoren-Inspiron-7460>
References: <cover.1539696960.git.ren_guo@c-sky.com>
 <3fff53d8-fca0-fee4-ae3b-c8b08dc29a37@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fff53d8-fca0-fee4-ae3b-c8b08dc29a37@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Oct 16, 2018 at 03:41:05PM +0100, Marc Zyngier wrote:
> Guo,
> 
> On 16/10/18 15:08, Guo Ren wrote:
> > This is about 13th patchset for C-SKY linux intc drivers and it should pair
> > with 9th kernel patchset. Timer drivers are seperated according to
> > requirements.
> > 
> > This version patch improve the comment in commit-msg and move the
> > changelog to the end with "---", so git am will ignore the changelog.
> > 
> > Hope it could be merged into linux-4.20 and I'm very grateful to any help.
> 
> I can't really see that happening, in all honesty. On its own, this code
> is not very useful (it cannot compile standalone), and I haven't seen a
> clear indication that the rest of the architecture code is going to be
> merged for 4.20.
Thank you very much for your frankness.

> If the arch code is actually being merged for 4.20, then please add my:
> 
> 	Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> to these 4 patches, and get the whole thing merged in one go.
> 
Got it, thx for the conditional Reviewed-by.

Best Regards
 Guo Ren
