Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeBBNyf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:54:35 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37527 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:54:30 -0500
Subject: Re: [PATCH v6 18/41] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
From: Sekhar Nori <nsekhar@ti.com>
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-19-git-send-email-david@lechnology.com>
 <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
Message-ID: <9f3640de-461e-de42-30ab-c1089f9dbc43@ti.com>
Date: Fri, 2 Feb 2018 19:23:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c2138795-edcd-bb7d-094d-47dc049c33df@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 February 2018 06:49 PM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +static const struct clk_ops da8xx_cfgchip_div4p5_clk_ops = {
>> +	.enable		= da8xx_cfgchip_gate_clk_enable,
>> +	.disable	= da8xx_cfgchip_gate_clk_disable,
>> +	.is_enabled	= da8xx_cfgchip_gate_clk_is_enabled,
> 
> I assume the reason for not using clk-gate.c is lack of regmap support
> there?

This is rather question for da8xx_cfgchip_gate_clk_ops. Sorry about the
bad context.

Thanks,
Sekhar
