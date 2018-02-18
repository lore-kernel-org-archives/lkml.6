Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeBROQK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:16:10 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36097 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeBROQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:16:07 -0500
X-Google-Smtp-Source: AH8x224VoWUjqvPBW5ayhL+IQ+goeBxqYBtIrk/TgP8ek48lhIjbwTAUXqXswyb2ERleoVssxuFJslfOg/+ure6Gfv4=
MIME-Version: 1.0
In-Reply-To: <20180218132256.GC695913@devbig577.frc2.facebook.com>
References: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
 <1518773953.22495.366.camel@linux.intel.com> <20180218132256.GC695913@devbig577.frc2.facebook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:16:06 +0200
Message-ID: <CAHp75Ve7Q2FDvLeN2PjbHsobvxckKq8L7YJddUWvfOVTWmvEqw@mail.gmail.com>
Subject: Re: [PATCH] sata_dwc_460ex: Delete an error message for a failed
 memory allocation in sata_dwc_port_start()
To: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 3:22 PM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Feb 16, 2018 at 11:39:13AM +0200, Andy Shevchenko wrote:
>> On Thu, 2018-02-15 at 22:22 +0100, SF Markus Elfring wrote:
>> > From: Markus Elfring <elfring@users.sourceforge.net>
>> > Date: Thu, 15 Feb 2018 22:15:25 +0100
>> >
>> > Omit an extra message for a memory allocation failure in this
>> > function.
>> >
>> > This issue was detected by using the Coccinelle software.
>>
>> Tejun, it's up to you. In case you are fine with the change,
>
> Yeah, these are marginal at best and one may be able to argue that
> emitting a message with device identifier is still useful but these
> allocations are order-zero and can't fail to begin with, so...

IIRC device core prints a warn with error code and device name if
->probe() fails.

-- 
With Best Regards,
Andy Shevchenko
