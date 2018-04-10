Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeDJTWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:22:45 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:44810 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDJTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:22:44 -0400
X-Google-Smtp-Source: AIpwx4+CD0AFVF78XpzQYZhMYKciLCBY34yylWydqwio6IhfQb4BPv/Cr47255aHEi8utrkK9V67xksILpBrXno/6sI=
MIME-Version: 1.0
In-Reply-To: <20180410171227.GA12596@smile.fi.intel.com>
References: <20180410171227.GA12596@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Apr 2018 12:22:43 -0700
X-Google-Sender-Auth: A95_VbKWmIWg35rM9PwQ-om6DaE
Message-ID: <CA+55aFxzkm0ELM4Xa_rkJpsv4hqeFa7yh2Tvkrh_xnhQqZs=Kg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.17-1
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:12 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This is first batch of Platform Drivers x86 for v4.17 cycle. Due to few
> duplication the merge will have conflicts which would be resolved by
> using `git merge -X no-renames ...` followed by choose of our version of
> two failed one-liner hunks situated in one file.

I'm not sure what git version or flags you are using, but git merges
it cleanly for me using the standard recursive merge policy.

                    Linus
