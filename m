Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBBGWU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:22:20 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:59885 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeBBGWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:22:13 -0500
Subject: Re: [PATCH v6 17/41] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP clocks
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-18-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
Date: Fri, 2 Feb 2018 11:50:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-18-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +EMIFA clock source (ASYNC1)
> +---------------------------
> +Required properties:
> +- compatible: shall be "ti,da850-async1-clksrc".
> +- #clock-cells: from common clock binding; shall be set to 0.
> +- clocks: phandles to the parent clocks corresponding to clock-names
> +- clock-names: shall be "pll0_sysclk3", "div4.5"

Is this clock really referred to as aysnc1 in documentation? I don't get
hits for async1 in OMAP-L138 TRM.

Thanks,
Sekhar
