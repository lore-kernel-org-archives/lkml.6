Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeCRUhL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:37:11 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:43959 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeCRUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:37:08 -0400
X-Google-Smtp-Source: AG47ELvjer8QPcaTpmSDqzeJiKbRfpGmMUEWlpOOl+7et+XrMxYKwW6PeTXyOEQmLa9LJpy/VxSfKg==
Subject: Re: [PATCH v3 01/15] dt-bindings: clock: mediatek: add missing
 required #reset-cells
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, sean.wang@mediatek.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
 <152123261872.225550.10226809804986023416@swboyd.mtv.corp.google.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <836d5d6e-eafa-52b8-39dc-6422ebe32d82@gmail.com>
Date: Sun, 18 Mar 2018 21:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152123261872.225550.10226809804986023416@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/16/2018 09:36 PM, Stephen Boyd wrote:
> Quoting sean.wang@mediatek.com (2018-02-17 11:54:36)
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> All ethsys, pciesys and ssusbsys internally include reset controller, so
>> explicitly add back these missing cell definitions to related bindings
>> and examples.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-clk@vger.kernel.org
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 

added to v4.16-next/dts64
Thanks!
