Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25076C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9920204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9920204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIZPIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:08:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbeIZPIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DE61ADA9;
        Wed, 26 Sep 2018 08:56:43 +0000 (UTC)
Date:   Wed, 26 Sep 2018 10:56:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
Message-ID: <20180926085645.GB5745@zn.tnic>
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
 <20180925190829.GC15464@zn.tnic>
 <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:08:04PM -0700, Nick Desaulniers wrote:

<snip>

> so this is hidden from GCC.  I can include this information in the
> commit message for a v2 if you'd like?

Yes please - in a condensed form. But explaining what happens makes it
much more clear, thanks for taking the time.

> We're in the process of adding asm goto support to Clang.  I'm helping
> test by working through compiling the Linux kernel with Clang for
> x86_64.  The patch set still has some kinks we're working out, but
> having this fix in place will make for smoother sailing once we're
> good to go, and we would appreciate having it.

I see.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
