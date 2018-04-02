Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeDBQLH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:11:07 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:53130 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeDBQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:11:01 -0400
X-Google-Smtp-Source: AIpwx4+NhTVjYkkErfwZGBizfrlKlKgWQ2oknDyYSGq9snci+Xk9FoW5b/EiHWYGskmonV3/248VWH/EK7dKd+mNAVo=
MIME-Version: 1.0
In-Reply-To: <20180402061443.yismaal7rly6ctpt@gmail.com>
References: <20180402061443.yismaal7rly6ctpt@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 09:11:00 -0700
X-Google-Sender-Auth: _gIr-06zapbVWMqAdYKq_1OLwBo
Message-ID: <CA+55aFz9zELeexAw8Yk6wgDcazGVFC6sbn_MWP7ZLVtigx2Odg@mail.gmail.com>
Subject: Re: [GIT PULL] misc core kernel changes
To: Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 11:14 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - add membarriers to Documentation/features/

You had actually done this earlier already, so now there are two
commits adding it.

Oh well.

                  Linus
