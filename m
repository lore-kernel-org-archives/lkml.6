Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeBBRuh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:50:37 -0500
Received: from vern.gendns.com ([206.190.152.46]:48054 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbeBBRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:50:23 -0500
Subject: Re: [PATCH v6 17/41] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP clocks
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-18-git-send-email-david@lechnology.com>
 <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <26fd0f01-ed14-6544-7443-e88c69ca9acb@lechnology.com>
Date: Fri, 2 Feb 2018 11:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 12:20 AM, Sekhar Nori wrote:
> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>> +EMIFA clock source (ASYNC1)
>> +---------------------------
>> +Required properties:
>> +- compatible: shall be "ti,da850-async1-clksrc".
>> +- #clock-cells: from common clock binding; shall be set to 0.
>> +- clocks: phandles to the parent clocks corresponding to clock-names
>> +- clock-names: shall be "pll0_sysclk3", "div4.5"
> 
> Is this clock really referred to as aysnc1 in documentation? I don't get
> hits for async1 in OMAP-L138 TRM.
> 

It looks like it is only called ASYNC1 in the datasheet, not the TRM.

Table 6-5. Maximum Internal Clock Frequencies at Each Voltage Operating
Point
