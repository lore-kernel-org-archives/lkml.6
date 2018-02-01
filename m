Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBALwA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:52:00 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:23398 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeBALvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:51:54 -0500
Subject: Re: [PATCH v6 13/41] clk: davinci: Add platform information for TI
 DM355 PSC
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-14-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <5fff33c5-68c3-4070-ddbd-4b8f91da8f4d@ti.com>
Date: Thu, 1 Feb 2018 17:20:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-14-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +	LPSC(26, 0, gpio,        pll1_sysclk2, gpio_clkdev,        0),
> +	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      0),
> +	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
> +	/* REVISIT: why can't this be disabled? */
> +	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,
> +	     LPSC_ALWAYS_ENABLED),
> +	LPSC(31, 0, arm,         pll1_sysclk1, NULL,
> +	     LPSC_ALWAYS_ENABLED),

IMO, in this case the line break makes it more difficult to read so that
checkpatch warning should be ignored.

Thanks
Sekhar
