Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeCRQGM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 12:06:12 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:34592 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeCRQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 12:06:06 -0400
X-Google-Smtp-Source: AG47ELso5gxvkIbPinieMcjHohG6iIQcSUyGHpX3RYMVXvUNkniDT1VBQIieoEO7Tbrrw6cEqWaJDyEEkUO+J8tY1Xo=
MIME-Version: 1.0
In-Reply-To: <000801d3bece$0e4b9090$2ae2b1b0$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <000801d3bece$0e4b9090$2ae2b1b0$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 18 Mar 2018 17:06:04 +0100
X-Google-Sender-Auth: UQQ-r-2xIh-aYztWbNuNLewbtSg
Message-ID: <CAJZ5v0h4aYDV8bzBGr2d2u3LFanturh-o9-PJpS4SFhuKS4zkg@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 4:30 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.18 04:01 Rafael J. Wysocki wrote:
>
>> Below is a drop-in v6 replacement for patch [4/7].
>>
>> With this new patch applied instead of the [4/7] the behavior should be much
>> more in line with the v4 behavior, so please try it if you can and let me know
>> if that really is the case on your systems.
>
> Yes, the idle power is back down to V4 levels. (I did not do a new graph).

Awesome, thanks!

> Some other data from this week (7 patch set + poll fix verses kernel 4.16-rc5):
>
> pipe-test: The not cross core test is the most dramatic. Using CPU's 3 and 7,
> or core 3, uses 6% less power and 18% performance improvement.
>
> Graphs:
> http://fast.smythies.com/pipe-test-one-core-power.png
> http://fast.smythies.com/pipe-test-one-core-times.png
>
> A couple of Phoronix tests (I didn't get very far yet):
> himeno: 11% performance improvement; 14% less power.
> compress-lzma: small performance improvement; small power improvement.
> mafft: performance similar; small power improvement.

Great news, thank you!
