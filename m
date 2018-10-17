Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699021523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699021523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJQRzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:55:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33018 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbeJQRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:55:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07938248|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.D3L4o5O_1539770396;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3L4o5O_1539770396)
          by smtp.aliyun-inc.com(10.147.42.253);
          Wed, 17 Oct 2018 17:59:56 +0800
Date:   Wed, 17 Oct 2018 17:59:45 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, jhogan@kernel.org, paul.burton@mips.com,
        peterz@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V13 0/4] C-SKY(csky) Linux Intc Driver
Message-ID: <20181017095945.GA3383@guoren-Inspiron-7460>
References: <cover.1539696960.git.ren_guo@c-sky.com>
 <3fff53d8-fca0-fee4-ae3b-c8b08dc29a37@arm.com>
 <20181017015511.GA21519@guoren-Inspiron-7460>
 <3043b2ca-cfa2-db70-b24a-fc473139991c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3043b2ca-cfa2-db70-b24a-fc473139991c@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Oct 17, 2018 at 09:29:45AM +0100, Marc Zyngier wrote:
> Hi Guo,
> 
> On 17/10/18 02:55, Guo Ren wrote:
> > Hi Marc,
> > 
> > On Tue, Oct 16, 2018 at 03:41:05PM +0100, Marc Zyngier wrote:
> >> Guo,
> >>
> >> On 16/10/18 15:08, Guo Ren wrote:
> >>> This is about 13th patchset for C-SKY linux intc drivers and it should pair
> >>> with 9th kernel patchset. Timer drivers are seperated according to
> >>> requirements.
> >>>
> >>> This version patch improve the comment in commit-msg and move the
> >>> changelog to the end with "---", so git am will ignore the changelog.
> >>>
> >>> Hope it could be merged into linux-4.20 and I'm very grateful to any help.
> >>
> >> I can't really see that happening, in all honesty. On its own, this code
> >> is not very useful (it cannot compile standalone), and I haven't seen a
> >> clear indication that the rest of the architecture code is going to be
> >> merged for 4.20.
> > Thank you very much for your frankness.
> > 
> >> If the arch code is actually being merged for 4.20, then please add my:
> >>
> >> 	Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> to these 4 patches, and get the whole thing merged in one go.
> >>
> > Got it, thx for the conditional Reviewed-by.
> 
> The Reviewed-by is not conditional, and you can apply it right now. What
> I meant is that I'm happy for you to get these irqchip patches merged
> with the rest of the architecture code.
Thank you and I agree that these patches should be merged with arch code
together.

Best Regards
 Guo Ren
