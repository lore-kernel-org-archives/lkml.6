Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeDLR6Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:58:25 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:40125 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDLR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:58:23 -0400
X-Google-Smtp-Source: AIpwx49Zilqf8JxP+hCdYp0moFDcwLT33vz1ZAcnptEzZhKoChnWS8xovjwclUmIsNgc2PcWQd5q9kqJ+tXaT5kvb48=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
References: <20180412015359.244491749@goodmis.org> <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 10:58:21 -0700
X-Google-Sender-Auth: BjgGXzP_-YK-HGoF675RWGpQnT0
Message-ID: <CA+55aFzPhRdZSX2wMiiact8RpnYMHy48RK+Ng7n_Ek_vpYy3fg@mail.gmail.com>
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and fixes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That doesn't exist, and makes no sense. Did you mean tracing, not ktest?

Oh, it's more f'ed up than that. That "ktest-v4.17-2" tag does exist -
in the tracing tree.

So the tag is mis-named, but in the right tree, and then your pull
request points at the wrong tree.

Do you want to fix that all up, or should I just pull from that messed-up thing?

                  Linus
