Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeFATqI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbeFATqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:46:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>, mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527021928-1243-1-git-send-email-daniel.lezcano@linaro.org>
Cc: leo.yan@linaro.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1527021018-31698-1-git-send-email-daniel.lezcano@linaro.org>
 <1527021928-1243-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <152788236518.225090.13622612110912822896@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk/driver/hisi: Consolidate the Kconfig for the CLOCK_STUB
Date: Fri, 01 Jun 2018 12:46:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JkEFI027314

Quoting Daniel Lezcano (2018-05-22 13:45:28)
> The current defconfig is inconsistent as it selects the mailbox and
> the clock for the hi6220 and the hi3660 without having their Kconfigs
> making sure the dependencies are correct. It ends up when selecting
> different versions for the kernel (for example when git bisecting)
> those options disappear and they don't get back, leading to unexpected
> behaviors. In our case, the cpufreq driver does no longer work because
> the clock fails to initialize due to the clock stub and the mailbox
> missing.
> 
> In order to have the dependencies correctly set when defaulting, let's
> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> automatically") where we select automatically the driver when the
> parent driver is selected. With sensible defaults in place, we can leave
> other choices for EXPERT.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied to clk-next
