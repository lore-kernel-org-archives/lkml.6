Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7FF20664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7FF20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJ3BMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:12:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36291 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbeJ3BMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:12:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1174397|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03276;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.DA8dwCT_1540830165;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DA8dwCT_1540830165)
          by smtp.aliyun-inc.com(10.147.41.231);
          Tue, 30 Oct 2018 00:22:45 +0800
Date:   Tue, 30 Oct 2018 00:22:45 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Message-ID: <20181029162243.GA988@guoren-Inspiron-7460>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Arnd,

On Mon, Oct 29, 2018 at 10:44:59AM +0100, Arnd Bergmann wrote:
[...]
> Guo, in the future I recommend to add all patches on top of the latest
> -rc1 (or maybe a later -rc) but not rebase them or pull in the mainline
> kernel into your own tree
Ok, I'll follow the rules.   

> 
> One more general comment: I think this may well be the last new CPU
> architecture we ever add to the kernel. Both nds32 and c-sky are made
> by companies that also work on risc-v, and generally speaking risc-v
> seems to be killing off any of the minor licensable instruction set projects,
> just like ARM has mostly killed off the custom vendor-specific instruction
> sets already. If we add another architecture in the future, it may instead
> be something like the LLVM bitcode or WebAssembly, who knows?
 ISA is like a language, we will learn foreign languages, but we will
 not give up our mother tongue. RISC-V is a great ISA, and it will
 promote other ISAs to be more open.

 From ecology, diversity will make Linux more robust.

 We will continue to improve csky subsystem, and now is only the
 beginning.

 Best Regards
  Guo Ren
