Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCTSBx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:01:53 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33391 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeCTSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:01:50 -0400
X-Google-Smtp-Source: AIpwx49tt0VHwyydBju6Q59kZeaearF66RWgl+9O5AO1p8mbDxnz3HEyiGxSYU8gjEXYMyznij+jhYXcj119Rl14UWQ=
MIME-Version: 1.0
In-Reply-To: <002901d3c074$2e315280$8a93f780$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <002901d3c074$2e315280$8a93f780$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Mar 2018 19:01:49 +0100
X-Google-Sender-Auth: s8HBYQiGhkOY6F6PhHEZnL-pIPs
Message-ID: <CAJZ5v0g-hrTBBT_Uk-1H4f=N2dNnUig2-qUiQW89ejaCoME0Ow@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 3/8] sched: idle: Do not stop the tick upfront in
 the idle loop
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 6:52 PM, Doug Smythies <dsmythies@telus.net> wrote:
> I am just trying to catch up. Switching to 4.16-rc6 and
> this new patch set.
>
> I think this patch 3/8 is incorrect, and is actually
> patch 2/8 repeated.

Yes, it is, sorry about that.

I've just sent the correct one in a reply to this message.

> I'll see if I can just apply the old v5 patch 3/7,
> and move on.

It should apply, it hasn't changed since v5.

Thanks!
