Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeBAJ4S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:56:18 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25188 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBAJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:56:16 -0500
Subject: Re: [PATCH v6 10/41] clk: davinci: New driver for davinci PSC clocks
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-11-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8c0c10ec-c1ec-89b3-ae7b-2df61c22779a@ti.com>
Date: Thu, 1 Feb 2018 15:25:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-11-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> This adds a new driver for mach-davinci PSC clocks. This is porting the
> code from arch/arm/mach-davinci/psc.c to the common clock framework and
> is converting it to use regmap to simplify the code. Additionally, it
> adds device tree support for these clocks.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the keystone
> driver makes the assumption that there is only one PSC per SoC and uses
> global variables, but here we have two controllers per SoC.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
