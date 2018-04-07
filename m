Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeDGVh1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 17:37:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38710 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeDGVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 17:37:25 -0400
X-Google-Smtp-Source: AIpwx4//JDjz9hSTd7WME06vmesNc2s+/bDaW8rI+l2rYuO+IkJnOMjIJY+sRzu0qu9mSUlN8uIuZaBAMAijbNxLW1c=
MIME-Version: 1.0
In-Reply-To: <20180407204414.GC30522@ZenIV.linux.org.uk>
References: <20180407204414.GC30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 14:37:24 -0700
X-Google-Sender-Auth: L-OiuJtVjENzhLYEiLhRsCP-u60
Message-ID: <CA+55aFyzdWyGZoczjCQE0rK1Bp9fq54DHNv-TqEeBvZ-C00VtQ@mail.gmail.com>
Subject: Re: [git pull] sparc syscall stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 7, 2018 at 1:44 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Conflicts in arch/sparc/kernel/sys_sparc32.c are not hard to resolve,
> but keep in mind that casts to u64 are needed there.  I'd pushed a variant of
> resolution into #test-merge.

You say "keep in mind that casts to u64 are needed there", but then
you seem to be missing them yourself in your test merge (see
[f]truncate64).

I only noticed because I decided to check my merge against yours. I
strive to always do the merge resolution, but if people give me a test
merge, I then double-check against it after-the-fack.

Hmm?

           Linus
