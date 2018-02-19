Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeBSPzl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:55:41 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:42483 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBSPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:55:39 -0500
X-Google-Smtp-Source: AH8x225pHJ3PI87DX91frkQecu1ahznAO2pI0WE3zFfIQL9JnWt2D2c/uKyJ4M3t/wIXz5s673btXOzkkRP7F8o4nmA=
MIME-Version: 1.0
In-Reply-To: <1510330017-32200-1-git-send-email-sudeep.holla@arm.com>
References: <1510330017-32200-1-git-send-email-sudeep.holla@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 19 Feb 2018 15:55:37 +0000
X-Google-Sender-Auth: 0S667elz7e4zuWtz6s_B-uf1cKs
Message-ID: <CAPKp9ubFmhRGaLvB5_Z-WCXiJZYH_W=V43e+Py1DWMk03rrMeg@mail.gmail.com>
Subject: Re: [PATCH] clk: versatile: add min/max rate boundaries for vexpress
 osc clock
To: open list <linux-kernel@vger.kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2017 at 4:06 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Clock framework has a provider API(clk_hw_set_rate_range) to set the
> min/max rate of a clock. Use the same to set the boundaries for the
> vexpress osc clock.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/clk/versatile/clk-vexpress-osc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Hi Stephen,
>
> Just a quick question, does the clk core ensure the round_rate request
> to the clock provider is within this bounds ? A quick grep suggests it's
> used after the call to round_rate in clk_calc_new_rates. I can't recall
> the details from when you introduced clk_hw_set_rate_range.
>

Ping !
