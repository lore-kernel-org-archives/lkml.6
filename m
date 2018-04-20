Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeDTLsF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:48:05 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:44968 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:48:04 -0400
X-Google-Smtp-Source: AIpwx4/tVUTIqYXeHmlAc4AroxfHCOeNOzTvxJJIEcPEx5Y0H+KqgPqZpwfq4gYo12xchR4KumJQSvQh9UMQK2lJG7Q=
MIME-Version: 1.0
In-Reply-To: <20180420082829.GE4064@hirez.programming.kicks-ass.net>
References: <20180414202831.GA20373@jordon-HP-15-Notebook-PC> <20180420082829.GE4064@hirez.programming.kicks-ass.net>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 20 Apr 2018 17:18:02 +0530
Message-ID: <CAFqt6zb3N3qVVcUOvd2F4q2P3PYrOoU8M3c=qSZDEpHokHHBaQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: event: core: Change return type to vm_fault_t
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm fine with the patch, but shouldn't this be part of a larger series /
> cocinelle script?
>

This one is trivial but many others are not.
As part of this clean up we have fixed many
existing bugs in fault handlers of drivers/
file systems. Also we are replacing existing
vm_insert_foo() with new vmf_insert_foo()
in fault handlers (wherever applicable).
Refer - 1c8f422059ae5da07db7406ab916203f9417e396
in 4.17-rc1
