Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55349ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42C92087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42C92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeIPG2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:28:47 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34123 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbeIPG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:28:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08387672|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04463;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CrM-jDr_1537060050;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CrM-jDr_1537060050)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 16 Sep 2018 09:07:30 +0800
Date:   Sun, 16 Sep 2018 09:07:30 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180916010729.GA18279@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> > Thanks to everyone who provided feedback on the previous version.
> >
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.18.4
> >
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> >          SMP ...)
> >
> > More information: http://en.c-sky.com
> 
> This looks good to me overall. I think a good next step would be to get the port
> included in linux-next, by preparing a git tree with all the patches and asking
> Stephen Rothwell to include it there. Further comments on the architecture
> port itself can be done on top of the existing patches. I would suggest you
> base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
> rebase again.
Another question:
Could I add "Acked-by: Arnd Bergmann <arnd@arndb.de>" in all my comments?

Best Regards
 Guo Ren
