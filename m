Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeE3Oxx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:53:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36412 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeE3Oxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:53:51 -0400
X-Google-Smtp-Source: ADUXVKJ8h0N8v01c+Qd8e1gAfIB2AuLxOMDzO2/gKt8vfBNnXHYEflbmNOfP4pt/dU00CPnki8TjEfe3mAzZzktVYCA=
MIME-Version: 1.0
In-Reply-To: <20180530143338.GM6920@sirena.org.uk>
References: <20180529221501.GJ5702@atomide.com> <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
 <20180530091314.GB6920@sirena.org.uk> <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
 <20180530143338.GM6920@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 May 2018 20:23:48 +0530
Message-ID: <CA+G9fYvff4_9XH8Y4CTadexb2WGV+rAd29Jdo4ztBxqFXKbt5Q@mail.gmail.com>
Subject: Re: Regression in Linux next again
To: Mark Brown <broonie@kernel.org>
Cc: Maciej Purski <m.purski@samsung.com>, Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 20:03, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 04:03:15PM +0200, Maciej Purski wrote:
>
>> I'm afraid, I have no idea, how to fix it quickly. You can revert it and
>> in the next version I'll fix the build error and split the last patch even
>> more, so we could perform a more precise bisection. I'd be grateful if you
>> could push it on your test coupled branch and Tony could test it again before
>> merging it with next again.
>
> Yeah, if we could get testing from Tony first that'd be ideal.

Linux next 4.17.0-rc7-next-20180529 boot failed on x15 device.
Manually reproduced boot failed problem on x15 device.
The qemu_arm32 boots successfully.

Ref bug:
LKFT: linux-next: Boot failed on beagle board x15
https://bugs.linaro.org/show_bug.cgi?id=3863
