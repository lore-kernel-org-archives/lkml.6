Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeCGVIf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:08:35 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:40513 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeCGVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:08:33 -0500
X-Google-Smtp-Source: AG47ELtxfxHFmtwtck++B2DPpYLq9v+v285Y3Y6WEBmhxD97LhMhNODYR+Fb0FDxQerb6O2V9hz7mtox82uH5+tZ/QQ=
MIME-Version: 1.0
In-Reply-To: <20180307132535.g7c2jro5n7okavbh@treble>
References: <20180306094920.16917-1-bp@alien8.de> <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic> <20180307132535.g7c2jro5n7okavbh@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 13:08:32 -0800
X-Google-Sender-Auth: yrwjhB-bpxzkXamvGZPKo_eLQfc
Message-ID: <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code: section
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 5:25 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> How about we just remove the 'code_bytes=' option?  (Or at the very
> least, reduce its possible range to a reasonable max?)

Ack. Just limit it to 64 bytes max sounds plenty.

             Linus
