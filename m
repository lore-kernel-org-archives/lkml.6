Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeE0Wvt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:51:49 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43799 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeE0Wvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:51:48 -0400
X-Google-Smtp-Source: ADUXVKLIxAce2ClZRMoNOBNIJAwGgtetbqgso0ctC7CPO9MtRCDxGiMIctCaErior3C1Rf2i2Qqsi3fMzk5qefDJ2fE=
MIME-Version: 1.0
In-Reply-To: <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
 <20180527200707.GC6349@zn.tnic> <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 28 May 2018 00:51:17 +0200
Message-ID: <CAEJqkghh0_kiRu3xaBSfaNSoJTDgNp1ep-03+XTiF2-_cFjASA@mail.gmail.com>
Subject: Re: smpboot seems to be confused on dual EPYC system
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-27 23:22 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>
> 2018-05-27 22:07 GMT+02:00 Borislav Petkov <bp@alien8.de>:
>>
>> On Sun, May 20, 2018 at 03:23:32PM +0200, Gabriel C wrote:
>> > Hello,
>> >
>> > I have an H11DSi-NT board with 2 *  EPYC 7281 16C/32T CPUs.
>> >
>> > On that box for some reason spmboot things '4' logical packages
>> > are possible.
>>
>> First of all, which kernel?
>
>

Here one box with single socket  with an AMD EPYC 7551P
on H11SSL-NC mobo running kernel 4.16.10:

...
[    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
[    0.030000] smpboot: CPU0: AMD EPYC 7551P 32-Core Processor
(family: 0x17, model: 0x1, stepping: 0x2)
[    0.545084] smpboot: Max logical packages: 2
[    0.545084] smpboot: Total of 64 processors activated (255989.37 BogoMIPS)
...

128CPUs for sure not possible and for sure no way to have '2' CPUs installed.
