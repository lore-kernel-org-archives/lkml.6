Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDLRxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:53:43 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:40770 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeDLRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:53:42 -0400
X-Google-Smtp-Source: AIpwx4966fMv8P5gaWD4uNWI1scrSNEFMBM9Zg2VVjKovyyC6lI9/VRVPY+C6pR7xV+1bM5D1+/v7/UQZCvBhAroQjE=
MIME-Version: 1.0
In-Reply-To: <20180412015359.244491749@goodmis.org>
References: <20180412015359.244491749@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 10:53:41 -0700
X-Google-Sender-Auth: HIMuNRjicrGRbLLIKy3C3gKqPZg
Message-ID: <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and fixes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 6:53 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Please pull the latest ktest-v4.17-2 tree, which can be found at:

That doesn't exist, and makes no sense. Did you mean tracing, not ktest?

And even if you did, why did your scripts not notice that the branch
you point to doesn't actually exist?

               Linus
