Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeFENMm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:12:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39917 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeFENMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:12:41 -0400
X-Google-Smtp-Source: ADUXVKIT637oGbFrq+uhaBKmenGOUozFxLNS6kD1l7zJu0ASrjCmKrPbMYmgeXz0VJhpJROvSf9nu6j5ocABu+K4T1Y=
MIME-Version: 1.0
In-Reply-To: <CADSz7_cqdKnmOm07Ykv5L9d2qscfKNmf7Vz=yW2Nf8PWsnsJaA@mail.gmail.com>
References: <CADSz7_cqdKnmOm07Ykv5L9d2qscfKNmf7Vz=yW2Nf8PWsnsJaA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:12:40 +0300
Message-ID: <CAHp75VcTvMKy8h_2gztav2FOUvE1QG01FByTNmc=x0bdyRx5Dg@mail.gmail.com>
Subject: Re: How to print stack uses of IRQ in ARM64
To: Vishnu Motghare <vishnumotghare@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you would like to get an answer in a reasonable time it might make
sense to Cc: people related to a subject.
I Cc:ed Marc here with hope he is a guy for the topic.

On Thu, May 31, 2018 at 1:01 PM, Vishnu Motghare
<vishnumotghare@gmail.com> wrote:
> I found this discussion (https://lwn.net/Articles/657969/) regarding
> implementation of separate IRQ stack for  ARM64.
>
> My understanding is each CPU  getting its own IRQ stack. So is it
> possible to print the stack uses of each IRQ handler? like, How much
> stack is used & how much left free ?
>
> like in process context we have API like stack_not_used(struct
> task_struct *p) to get the unused stack  of processes. So, is it
> possible to get the similar result for IRQ?



-- 
With Best Regards,
Andy Shevchenko
