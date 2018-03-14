Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCNP3i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:29:38 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:41725 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:29:37 -0400
X-Google-Smtp-Source: AG47ELuLYy8KdeNprdlOIHolZVqL0UDqTepI6PLm2Bf5OauZcPHDkKSZTsBIOJkcsbXdnLen+8p9rIYOmj0v+gPgZCM=
MIME-Version: 1.0
In-Reply-To: <08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
 <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
 <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com> <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
 <08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 17:29:36 +0200
Message-ID: <CAHp75VeEUCVSKLH0aobk=+GjVHWgO_OAKZRCx8gqDc9tWvESMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 5:24 PM, Gary R Hook <gary.hook@amd.com> wrote:
> On 03/13/2018 03:23 PM, Andy Shevchenko wrote:

>>>>> +#include <linux/pci.h>
>>>>> +#include <linux/iommu.h>
>>>>> +#include <linux/debugfs.h>

>>>> Keep in order?

>>> What order would that be? These few needed files are listed in the same
>>> order as which they appear in amd_iommu.c. I'm gonna need a preference
>>> spelled out, please (and a rationale, so I may better understand).

>> To increase readability and avoid potential header duplication (here
>> is can bus protocol implementation where the problem exists for real,
>> even in new code!)

> With all due respect, I don't find that you clearly answered my question.

Alphabetical order I meant.

> I
> will hazard a guess that you mean to -alphabetize- them? Which I am happy to
> do, and will do so in the next version.

Yes, please.

-- 
With Best Regards,
Andy Shevchenko
