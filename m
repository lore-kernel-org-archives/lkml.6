Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754469AbeCHQh6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:37:58 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39530 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeCHQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:37:56 -0500
X-Google-Smtp-Source: AG47ELtV8ZuXKH/Vk/fEXtlAfwq0TZ69HXsL2r5V5irtgnMIpSswL3VzvmkDkwQP+kjsYAGVZiyHu/1YIQSBW9M5Hys=
MIME-Version: 1.0
In-Reply-To: <000a01d3b6f0$c870d380$59527a80$@net>
References: <000a01d3b636$57b75c00$07261400$@net> <000a01d3b6f0$c870d380$59527a80$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Mar 2018 17:37:55 +0100
X-Google-Sender-Auth: p1tfoRM3O-feBl3aT9fzF68X_JE
Message-ID: <CAJZ5v0gjB+8rgKNO_3FDnuJZjbjW0mxjptd6h1--McwGjTKj9A@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 4:18 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.07 17:29 Doug wrote:
>> On 2018.03.07 14:12 Rafael J. Wysocki wrote:
>>> On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>>>
>>>> During the test I got some messages (I also got some with the V1 patch set):
>>
>>> Can you please check if that's reporoducible with just the first three
>>> patches in the series applied?
>>
>> I will.
>
> No issues. Test duration: 7 hours and 26 minutes.
> Boot seems normal. Times re-booted 4.

Cool, thanks!

This means that the other patches introduce the problem, most likely.
