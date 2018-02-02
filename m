Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBBGQ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeBBGQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:16:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D06C21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 14:16:41 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH v2 1/7] ARM: imx: add timer stop flag to ARM power off
 state
Message-ID: <20180202061605.GL20833@dragon>
References: <20180110210453.19264-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110210453.19264-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2018 at 10:04:47PM +0100, Stefan Agner wrote:
> When the CPU is in ARM power off state the ARM architected
> timers are stopped. The flag is already present in the higher
> power WAIT mode.
> 
> This allows to use the ARM generic timer on i.MX 6UL/6ULL SoC.
> Without the flag the kernel freezes when the timer enters the
> first time ARM power off mode.
> 
> Note: The default timer on i.MX6SX is the i.MX GPT timer which is
> not disabled during CPU idle. However, the timer is not affected
> by the CPUIDLE_FLAG_TIMER_STOP flag. The flag only affects CPU
> local timers.
> 
> Cc: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied all, thanks.
