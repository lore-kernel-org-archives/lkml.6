Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeAaFSV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:18:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36933 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeAaFST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:18:19 -0500
X-Google-Smtp-Source: AH8x2255w52Vcu4on3aNmX/JpVlgBl3BGvz9QZl14f/81L5O3dkpD4fD0jSWNa8NeFyqY8hpf1z59A==
Date: Wed, 31 Jan 2018 10:48:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/8] thermal/drivers/cpu_cooling: Add Software Package
 Data Exchange (SPDX)
Message-ID: <20180131051816.GH13395@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-3-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516721671-16360-3-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18, 16:34, Daniel Lezcano wrote:
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
>   *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
>   *		Viresh Kumar <viresh.kumar@linaro.org>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
