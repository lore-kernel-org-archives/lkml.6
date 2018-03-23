Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeCWOG7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:06:59 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34795 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbeCWOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:06:58 -0400
X-Google-Smtp-Source: AIpwx4/giT5RGmj/vJo7xqK9Z0oyuTvc6E79WhtiTpoB+JTBxQNuwdoeTsM4yNN3l9rm7bWvTuTIEQI48MWGgV+MyVE=
MIME-Version: 1.0
In-Reply-To: <1521649925-13804-2-git-send-email-jason.vas.dias@gmail.com>
References: <1521649925-13804-1-git-send-email-jason.vas.dias@gmail.com> <1521649925-13804-2-git-send-email-jason.vas.dias@gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Fri, 23 Mar 2018 14:06:55 +0000
Message-ID: <CALyZvKyN+O3FAqZdHaq73=X9RBrrybt9mBm-6WpVUkNPzTGx4Q@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc6 1/1] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day -

I believe the last patch I sent, with $subject,
addresses all concerns raised so far by reviewers,
and complies with all kernel coding standards .

Please, it would be most helpful if you could let
me know whether the patch is now acceptable
and will be applied at some stage or not - or if not,
what is the problem with it .

My clients are asking whether the patch is going
to be in the upstream kernel or not, and I need
to tell them something.

Thanks & Best Regards,
Jason
