Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755912AbeEAOSR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:18:17 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:44503 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755849AbeEAOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:18:15 -0400
Subject: Re: [PATCH v9 06/27] ARM: davinci: da850: add new clock init using
 common clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-7-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <525160f1-056b-69d1-2ce2-e5bdff8bffcc@ti.com>
Date: Tue, 1 May 2018 19:47:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-7-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/da850.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Some CFGCHIP macros were removed because we are now including
> linux/mfd/da8xx-cfgchip.h which defines the same values.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
