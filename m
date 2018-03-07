Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeCGPV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:21:27 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:46011 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:21:24 -0500
X-Google-Smtp-Source: AG47ELs4iuDC4OK7CAarSCmpgyWJdczfSKiwJUgcmKxKEPsowHTiS+0oZRv53VasuSfM9RajvX+dCTJPTTts19qDWRo=
MIME-Version: 1.0
In-Reply-To: <pull-1520273005-304551@atomide.com-2>
References: <pull-1520273005-304551@atomide.com> <pull-1520273005-304551@atomide.com-2>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:21:22 +0100
X-Google-Sender-Auth: _IG2U95HgoXMVV1gB7txdRJpI88
Message-ID: <CAK8P3a0YwGtE+UkA6+rQ_FQsGO5paL9ub_=oOq_SE3xPUiH1ww@mail.gmail.com>
Subject: Re: [GIT PULL 2/6] omap timer changes for v4.17
To: Tony Lindgren <tony@atomide.com>
Cc: arm-soc <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 2fdc82776ac2ac49c5ee666d834718ac36420e49:
>
>   Merge branch 'omap-for-v.16/dmtimer-fix' into omap-for-v4.17/timer (2018-02-22 10:46:47 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/timer-signed
>
> for you to fetch changes up to 58a54f03e73d67432216931854363e4ba15839b9:
>
>   clocksource: timer-ti-dm: Check prescaler value (2018-02-28 13:41:30 -0800)
>
> ----------------------------------------------------------------
> Move omap timer to drivers for 4.17
>
> This series from Keerthy and Ladislav Michl move omap dmtimer code
> to drivers. As we don't want to export custom timer functions to
> random drivers, we also need to update the related PWM driver to
> pass the timer specific functions in platform data.
>
> Note that this series is based on a merge of omap1 specific timer
> fix and omap2+ platform data clean-up to keep things working and
> make the move a bit simpler.

I was undecided whether this should be in next/drivers or next/soc,
ended up putting it into the latter.

I don't see the clocksource maintainers involved in the patch series,
so I added them to Cc now to make sure they are aware of the move
of the driver.

       Arnd
