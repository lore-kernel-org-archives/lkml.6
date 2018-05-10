Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966242AbeEJPbN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:31:13 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:14664 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965949AbeEJPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:31:11 -0400
Subject: Re: [PATCH v3 2/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <20180509153642.22399-1-david@lechnology.com>
 <20180509153642.22399-3-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <05fe08f6-5860-6734-2982-01a2afd63980@ti.com>
Date: Thu, 10 May 2018 21:00:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509153642.22399-3-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2018 09:06 PM, David Lechner wrote:
> This fixes the parent clock names of the SYSCLKn clocks for the DM355
> SoC in the TI DaVinici PLL clock driver.
> 
> It appears that this name just didn't get updated to the correct name
> like the other SoCs during the driver's development.
> 
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
