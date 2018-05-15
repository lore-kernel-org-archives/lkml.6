Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEOVIK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:08:10 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51672 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeEOVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:08:01 -0400
X-Google-Smtp-Source: AB8JxZpLL0Iyz13k6hs3K+zenLLnbIdxDMEJgpk5p+lzpkJ9raZ019Adh0Pa08YN0++bfI2Wn6d8ng==
Date: Wed, 16 May 2018 00:07:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        tipbuild@zytor.com, lkp@01.org
Subject: Re: [lkp-robot] [x86/asm]  51bad67ffb: int3:#[##]
Message-ID: <20180515210757.GA12225@avx2>
References: <20180515080033.GA7714@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515080033.GA7714@yexl-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 04:00:33PM +0800, kernel test robot wrote:

> [   11.182501] Code: 00 00 00 eb e6 cc cc cc cc cc cc cc cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 5d e8 8f ff 8b 44 24 34 83 e0 03 83 f8 03 72 28 cc <cc> cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 3d e8 8f ff 89 e0 
> [   11.184326] EIP: ret_from_intr+0xd/0x14 SS:ESP: 0068:8603bfb4

INT3 slipped through M586 => X86_ALIGNMENT_16 :-\
