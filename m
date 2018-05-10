Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965707AbeEJOYY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:24:24 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:43065 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:24:22 -0400
X-Google-Smtp-Source: AB8JxZodOW21TonQtH1P+czLHbjZyTS1PDmBqi7BhBM0AxVizw6nWqluheO9Hriqw7v721IPM0QGhX27nHtZOE0zMFs=
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb3N3qVVcUOvd2F4q2P3PYrOoU8M3c=qSZDEpHokHHBaQ@mail.gmail.com>
References: <20180414202831.GA20373@jordon-HP-15-Notebook-PC>
 <20180420082829.GE4064@hirez.programming.kicks-ass.net> <CAFqt6zb3N3qVVcUOvd2F4q2P3PYrOoU8M3c=qSZDEpHokHHBaQ@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 10 May 2018 19:54:20 +0530
Message-ID: <CAFqt6zaQKhijpVX6GrfwSx=_z7FOp_NoF9TTf2Gjgv+mg0TMSg@mail.gmail.com>
Subject: Re: [PATCH] kernel: event: core: Change return type to vm_fault_t
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 5:18 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> I'm fine with the patch, but shouldn't this be part of a larger series /
>> cocinelle script?
>>
>
> This one is trivial but many others are not.
> As part of this clean up we have fixed many
> existing bugs in fault handlers of drivers/
> file systems. Also we are replacing existing
> vm_insert_foo() with new vmf_insert_foo()
> in fault handlers (wherever applicable).
> Refer - 1c8f422059ae5da07db7406ab916203f9417e396
> in 4.17-rc1

Any further comment on this patch ?
