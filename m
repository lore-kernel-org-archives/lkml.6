Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeDWLX0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:23:26 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34720 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbeDWLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:23:25 -0400
X-Google-Smtp-Source: AIpwx4+XkIzRDeegaDTceJSLwTpmk9eG/cVxBGwjhuyxAZJQn5A4oY+Xb9ohFDlcEgYn5lx+ctsMEQT4YwZGbahxSm8=
MIME-Version: 1.0
In-Reply-To: <20180423091633.GU4064@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net>
From: Diego Viola <diego.viola@gmail.com>
Date: Mon, 23 Apr 2018 08:23:24 -0300
Message-ID: <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 6:16 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Apr 21, 2018 at 11:19:55PM -0300, Diego Viola wrote:
>
>> The problem only happens *after* resuming from suspend, in normal S0
>> state it never happens.
>
> What kind of suspend are you doing? s2disk, s2ram ?

Suspend to RAM with systemctl suspend.

>
>> My machine is a desktop and has a dual core E5500 CPU with 2GB of RAM,
>> I run Arch Linux and I use the i3wm.
>
> That's a Core2 era chip; does it actually have stable TSC ?

I'm not sure.

>
>> aa83c45762a242acce9b35020363225a7b59d7c9 is the first bad commit
>
> That is most curious; that was supposed to only affect early boot. I'll
> try and figure out of there's some intersection with suspend.

Thanks.
