Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeEGHtu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:49:50 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53871 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeEGHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:49:47 -0400
X-Google-Smtp-Source: AB8JxZqK+bcSoDBTAJI/Z6MbJvyD6wPtmmVOL7JqIYxbWlmilm1zqXyoRJ32I2BCmQxlh5Bvp1KqZg==
Date: Mon, 7 May 2018 09:49:43 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>
Subject: Re: [PATCH] clocksource/drivers/sprd: Fix Kconfig dependency
Message-ID: <20180507074943.GB19313@mai>
References: <1525350452-14433-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <20180507055130.GA19313@mai>
 <CAAfSe-uBy00gR+Upcc1aO0LWwLMGT-WrCmt4oo_SiEXUcW+PuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfSe-uBy00gR+Upcc1aO0LWwLMGT-WrCmt4oo_SiEXUcW+PuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:04:38PM +0800, Chunyan Zhang wrote:
> Hi Daniel,
> 
> On 7 May 2018 at 13:51, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > On Thu, May 03, 2018 at 08:27:32PM +0800, Chunyan Zhang wrote:
> >> SPRD arch doesn't select SPRD_TIMER, so this config would not
> >> appear even if ARCH_SPRD is set and COMPILE_TEST is not.
> >>
> >> Fix the Kconfig selection rule by letting the SPRD arch to select.
> >
> > Instead of changing this Kconfig, please fix the arch's Kconfig by selecting
> > SPRD_TIMER.
> 
> Oh, that's not my expectation, I hope we can give users permission of
> not selecting SPRD TIMER driver even if SPRD arch is selected. (I can
> confirm that all Spreadtrum's platforms in mainline can work without
> this driver. An enough minimum workable system doesn't need this
> driver indeed.)

Ok, can you add the EXPERT option in addition to the bool like:

https://lkml.org/lkml/2018/4/3/897

Thanks.

  -- Daniel


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
