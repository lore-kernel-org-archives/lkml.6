Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496FC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6BC2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfAGUDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:03:43 -0500
Received: from namei.org ([65.99.196.166]:54882 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGUDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:03:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x07K3SpE009573;
        Mon, 7 Jan 2019 20:03:28 GMT
Date:   Tue, 8 Jan 2019 07:03:28 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
In-Reply-To: <20190107101540.GA87402@gmail.com>
Message-ID: <alpine.LRH.2.21.1901080702590.2451@namei.org>
References: <alpine.LRH.2.21.1812311511360.1435@namei.org> <20190107101540.GA87402@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019, Ingo Molnar wrote:

> 32-bit x86 allyesconfig doesn't build:
> 
>  /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
>  /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
>  /usr/bin/ld: final link failed: File in wrong format
>  collect2: error: ld returned 1 exit status
>  scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
>  make[2]: *** [samples/seccomp/user-trap] Error 1
> 
> Is this a known regression?
> 

Not that I'm aware of (cc Kees).


-- 
James Morris
<jmorris@namei.org>

