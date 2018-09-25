Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8FA20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8FA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIZBR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:17:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbeIZBR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:17:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A21E2AD12;
        Tue, 25 Sep 2018 19:08:27 +0000 (UTC)
Date:   Tue, 25 Sep 2018 21:08:29 +0200
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
Message-ID: <20180925190829.GC15464@zn.tnic>
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:41:19AM -0700, Nick Desaulniers wrote:
> bumping for review.
> 
> On Fri, Sep 7, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Since this file steamrolls KBUILD_CFLAGS, we have to redefine these
> > symbols.

Why do we have to redefine these symbols?

I don't see arch/x86/boot/ using asm_volatile_goto() and
CC_HAVE_ASM_GOTO anywhere.

> > This will prevent warnings in source files in this directory
> > when Clang supports asm goto.

This statement I can't grok either. Maybe I'm slow or maybe I need more
background info...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
