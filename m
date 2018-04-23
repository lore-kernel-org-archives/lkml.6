Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbeDWLt1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:49:27 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37294 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeDWLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:49:26 -0400
X-Google-Smtp-Source: AIpwx49RBPi14/3KTzd0dl2jaERWifVw2kavGru9QEBEpCDTjaSqkhzJNBnN76QfQpIwmWr1uRJuhFeCGnn35rLlpYQ=
MIME-Version: 1.0
In-Reply-To: <20180423114850.GK4082@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net> <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net>
From: Diego Viola <diego.viola@gmail.com>
Date: Mon, 23 Apr 2018 08:49:25 -0300
Message-ID: <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 8:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 23, 2018 at 08:23:24AM -0300, Diego Viola wrote:
>> > That's a Core2 era chip; does it actually have stable TSC ?
>>
>> I'm not sure.
>
> dmesg | grep -i tsc
>
> should be able to tell you.

[diego@dualcore ~]$ dmesg | grep -i tsc
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.016666] tsc: Fast TSC calibration using PIT
[    0.019999] tsc: Detected 2793.087 MHz processor
[    0.019999] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2842be30f1f, max_idle_ns: 440795236296 ns
[    0.162058] clocksource: Switched to clocksource tsc-early
[    0.300076] tsc: Marking TSC unstable due to TSC halts in idle
[diego@dualcore ~]$
