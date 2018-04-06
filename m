Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDFC4H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:56:07 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33781 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeDFC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:56:06 -0400
X-Google-Smtp-Source: AIpwx497cXubuY5hRmAXLfN/OHPn+0vAQ59Cke6SKOvdFsi4YISOUnyJ6gclI89SNcpjtUbuvuZHR/2H9oyLNXxpIos=
MIME-Version: 1.0
In-Reply-To: <20180404123910.e2rrfmau7f7jcb7i@pathway.suse.cz>
References: <20180404123910.e2rrfmau7f7jcb7i@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 19:56:04 -0700
X-Google-Sender-Auth: O_jtRf43BGToRMcVc9RoHjEmc1A
Message-ID: <CA+55aFyukB0HkH+58ssWeEL-xBbcpwO1mcfYoPEO0gPPEXQjtg@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 4.17
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 5:39 AM, Petr Mladek <pmladek@suse.com> wrote:
>
> Petr Mladek (1):
>       Merge branch 'for-4.17' into for-linus

Please don't do this.

There was no reason for it, and the commit message says:

  "Merge branch 'for-4.17' into for-linus"

which also doesn't tell why that merge would have existed.

You should just have asked me to pull "for-4.17". Or renamed the
branch to "for-linus". There was no reason for the merge that I can
see.

So what I actually did was to just pull your 'for-4.17' branch
instead, which got me the exact same end result.

                   Linus
