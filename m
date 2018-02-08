Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBHOFz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:05:55 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51210 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBHOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:05:53 -0500
X-Google-Smtp-Source: AH8x226Nvgj8nZi9ouJqbUxtHLiMyvRdYMgMEX87PshSUHnj4oVMC0rsMr8JK0jvUZOcGxHHoXtkn6/VW0DTQc4ySVI=
MIME-Version: 1.0
In-Reply-To: <1516721671-16360-3-git-send-email-daniel.lezcano@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org> <1516721671-16360-3-git-send-email-daniel.lezcano@linaro.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:05:11 +0100
Message-ID: <CAOFm3uEbg213MdHJrDthzH58udSAH4hErUo7osntZaMoAW5EDw@mail.gmail.com>
Subject: Re: [PATCH 2/8] thermal/drivers/cpu_cooling: Add Software Package
 Data Exchange (SPDX)
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Tue, Jan 23, 2018 at 4:34 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> For license auditing purpose, let's add the SPDX tag.
>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 988fc55..e62be75 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
> @@ -8,21 +9,6 @@
>   *  Authors:   Amit Daniel <amit.kachhap@linaro.org>
>   *             Viresh Kumar <viresh.kumar@linaro.org>
>   *
> - * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; version 2 of the License.
> - *
> - *  This program is distributed in the hope that it will be useful, but
> - *  WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - *  General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> - *
> - * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */
>  #include <linux/module.h>
>  #include <linux/thermal.h>


Sorry for the late reply!
Thank you.
Acked-by: Philippe Ombredanne <pombredanne@nexB.com>

--
Philippe
