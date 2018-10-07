Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B539C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 04:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4910620882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 04:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4910620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeJGLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 07:54:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33948 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbeJGLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 07:54:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08991465|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.D-V7pfc_1538887695;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D-V7pfc_1538887695)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 07 Oct 2018 12:48:16 +0800
Date:   Sun, 7 Oct 2018 12:48:15 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, green.hu@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V7 00/20] C-SKY(csky) Linux Kernel Port
Message-ID: <20181007044815.GA27049@guoren-Inspiron-7460>
References: <cover.1538715563.git.ren_guo@c-sky.com>
 <20181006200649.GL32759@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006200649.GL32759@asgard.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 10:06:49PM +0200, Eugene Syromiatnikov wrote:
> On Fri, Oct 05, 2018 at 01:41:42PM +0800, Guo Ren wrote:
> > This is the 7th version patchset to add the Linux kernel port for
> > C-SKY(csky) based on linux-4.19-rc3.
> > 
> > In this patchset some fixup patches are folded into original patch in
> > order to make review clearly and reduce the patches' number for upstream
> > patchset. The changelog is added in the every patch's commit-msg.
> > 
> > Here is the LTP test report for this patchset:
> > (and add "V10 C-SKY(csky) Linux Kernel Driver" patchset)
> > -----------------------------------------------
> > Total Tests: 1298
> > Total Skipped Tests: 280
> > Total Failures: 11
> > Kernel Version: 4.19.0-rc3+
> > Machine Architecture: csky
> > Hostname: buildroot
> > -----------------------------------------------
> > 
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > 
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> > 	 SMP ...)
> > More information: http://en.c-sky.com
> > The development repo: https://gitlab.com/c-sky/csky-linux
> 
> I'm sorry for my ignorance, but I'm struggling to find ISA reference/manual,
> architecture programming manual, and System V ABI definition;
> may I ask to give links to them?
Here is the link: https://github.com/c-sky/csky-doc

Best Regards
 Guo Ren
