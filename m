Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525C320851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525C320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeJ2SdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:33:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41147 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ2SdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:33:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so8393147qtl.8;
        Mon, 29 Oct 2018 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWc9XnPG4Gfy49eyLtufw+7TwqxHm1uIc1ndRudUdxc=;
        b=d4RaDXAfjpj7uXWF/oy00sZ6p1aJy9FTPoNa58AuXiv/0YqvOTEVe+KJQ3mXqSAGWl
         +oa/TL3+ieObhhSRH0JSSJtuanBvCS+2knqvo46s9XwPXA9DM2vwf9piQobOcwTC1yoe
         AZKZh5BspP/q4xzTv7EIM+SvQYdosXB4CUCIMebVcS9cesKP3aQnQnHOo7Iujhmuuax0
         KUIjezL7aCVnXw5WFSvZLDan6C8Ovbq7WOqjG6AKjFroyxI0kYXcaAMUo1Qemerl8nsa
         0zZj1CTY5BeftQZslkqyn5Jw1isnLTAq1Vy5Im/+nGpTIG5NJ13F7za0uwBTQzfYf+E/
         MdYw==
X-Gm-Message-State: AGRZ1gIQCkgNFzIWtMS1UvDatlH8MU8N7PWb4HBPWxPcKsRCUrs1m2Pi
        x1FbZVex5FZyCOvcN6RFpzwdSRWqC2KapYtbEwM=
X-Google-Smtp-Source: AJdET5ft4Zjd5Ynw+8Zpvd7e78xFsPpovy9BXPunjutU0IKuVroqwO69NK2Kfg4UJ3fjlmAmHBqUizvpec/j7LZYN7A=
X-Received: by 2002:a0c:8d4b:: with SMTP id s11mr12130328qvb.161.1540806316682;
 Mon, 29 Oct 2018 02:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com> <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
In-Reply-To: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 10:44:59 +0100
Message-ID: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Arnd,
>  I was kind of hoping/expecting to get an explicit ack for this from
> you, since it's a new architecture.
>
> Good to merge?

Yes.

For the pull request (in case you want to add it to the merge changelog):

I did a thorough review of the ABI, which as usual mainly consists of spotting
any files that don't use the asm-generic ABI itself, and having it changed to
it matches exactly what we do on other new architectures.

I also looked at every other patch and commented on maybe half of them
where I saw something that did not quite seem right. Others have reviewed
specific patches in greater depth. I'm sure that one could fine more of the
minor details, but as long as they are not ABI relevant, they can be fixed
later.

The only patch that is part of the ABI and that nobody reviewed is the
signal handling. This is one of the areas I never worked on in much detail.
I did not see anything wrong with it, but I also don't know what the problems
with the other architectures are here, and we seem to be hitting issues
occasionally, and we never managed to generalize this enough for new
architectures to have a trivial implementation.

I was originally hoping that we could have the 64-bit time_t interfaces
ready in time to completely drop the 32-bit ones, but that did not
happen. We might still remove them in the next merge window
depending on whether the libc upstream people prefer to keep them
or not.

Acked-by: Arnd Bergmann <arnd@arndb.de>
---
You may note that Guo rebased the series on top of v4.19. I tried
to explain a while ago that it's better not to do that, but I suppose he
was trying to add the last-minute Acks and it seemed like a good idea.

Guo, in the future I recommend to add all patches on top of the latest
-rc1 (or maybe a later -rc) but not rebase them or pull in the mainline
kernel into your own tree.

One more general comment: I think this may well be the last new CPU
architecture we ever add to the kernel. Both nds32 and c-sky are made
by companies that also work on risc-v, and generally speaking risc-v
seems to be killing off any of the minor licensable instruction set projects,
just like ARM has mostly killed off the custom vendor-specific instruction
sets already. If we add another architecture in the future, it may instead
be something like the LLVM bitcode or WebAssembly, who knows?

       Arnd
