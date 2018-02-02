Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBBOBR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:01:17 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37856 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBOBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:01:10 -0500
Subject: Re: [PATCH v6 19/41] clk: davinci: New driver for TI DA8XX USB PHY
 clocks
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-20-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <abb566ad-e5fd-a09c-e8b7-695ca7c126fa@ti.com>
Date: Fri, 2 Feb 2018 19:29:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-20-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
> index 54ea3ff..04b48b3 100644
> --- a/include/linux/clk/davinci.h
> +++ b/include/linux/clk/davinci.h
> @@ -9,6 +9,9 @@
>  
>  #include <linux/types.h>
>  
> +struct clk;
> +struct regmap;

Its probably better to include clk-provider.h and regmap.h?

Thanks,
Sekhar
