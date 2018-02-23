Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeBWF1A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:27:00 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:38611 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBWF06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:26:58 -0500
X-Google-Smtp-Source: AG47ELsEFRxJ9CjXsc8Q/6bl0kx6tRvO+nKtm3Ol2sn05X52tFUyLoUH2+8Jat3Bx7Ff/Nwve3U2XUNKpmEjK4cP1Ns=
MIME-Version: 1.0
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 23 Feb 2018 10:56:56 +0530
X-Google-Sender-Auth: 1sXEUowmuncYJVNTz-m8h984rVE
Message-ID: <CAOh2x=mDbE=DpRc7Jseccc_VNuq8XOQcCE4xLbJXAuqR8k=+NA@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, kevin.wangtao@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, amit.kachhap@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javi.merino@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        daniel.thompson@linaro.org, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:59 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Changelog:
>   V2:
>      - Dropped the cpu combo cooling device
>      - Added the acked-by tags
>      - Replaced task array by a percpu structure
>      - Fixed the copyright dates
>      - Fixed the extra lines
>      - Fixed the compilation macros to be reused
>      - Fixed the list node removal
>      - Massaged a couple of function names

There are few patches in this series, including the cover-letter,
where your script
forgot to cc me and probably other cpu-cooling maintainers.

Maybe just explicitly cc us all next time :)

--
viresh
