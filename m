Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeEGGFV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:05:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43666 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeEGGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:05:19 -0400
X-Google-Smtp-Source: AB8JxZr2pLpbFxKpw6cjykXm1n50Dr5bELPpzPUihXpvl61/gRluDzjLuCX1t95Mz4ofOeGJESI+whyKd5T+WE2vj/A=
MIME-Version: 1.0
In-Reply-To: <20180507055130.GA19313@mai>
References: <1525350452-14433-1-git-send-email-chunyan.zhang@spreadtrum.com> <20180507055130.GA19313@mai>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 7 May 2018 14:04:38 +0800
Message-ID: <CAAfSe-uBy00gR+Upcc1aO0LWwLMGT-WrCmt4oo_SiEXUcW+PuA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/sprd: Fix Kconfig dependency
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 7 May 2018 at 13:51, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On Thu, May 03, 2018 at 08:27:32PM +0800, Chunyan Zhang wrote:
>> SPRD arch doesn't select SPRD_TIMER, so this config would not
>> appear even if ARCH_SPRD is set and COMPILE_TEST is not.
>>
>> Fix the Kconfig selection rule by letting the SPRD arch to select.
>
> Instead of changing this Kconfig, please fix the arch's Kconfig by selecting
> SPRD_TIMER.

Oh, that's not my expectation, I hope we can give users permission of
not selecting SPRD TIMER driver even if SPRD arch is selected. (I can
confirm that all Spreadtrum's platforms in mainline can work without
this driver. An enough minimum workable system doesn't need this
driver indeed.)

Thanks,
Chunyan
