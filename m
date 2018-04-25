Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeDYOcO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:32:14 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:41818 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753939AbeDYOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:32:12 -0400
Subject: Re: [PATCH v6 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
To: Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
References: <20180419135426.155794-1-yixun.lan@amlogic.com>
 <1524661512.4026.67.camel@baylibre.com>
CC: <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <2a307212-ea12-e7a1-cf6a-9fd7d9e9bb40@amlogic.com>
Date: Wed, 25 Apr 2018 22:32:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1524661512.4026.67.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.49]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome:

On 04/25/2018 09:05 PM, Jerome Brunet wrote:
> On Thu, 2018-04-19 at 21:54 +0800, Yixun Lan wrote:
>>   This patch try to add AO clock and Reset driver for Amlogic's
>> Meson-AXG SoC.
>>   Please note that patch 7 need to wait for the DTS changes[3] merged
>> into mainline first, otherwise it will break the serial console.
>>
>>  patch 2: factor the common code into a dedicated file
>>  patch 3-5: add the aoclk driver for AXG SoC
>>  patch 6-7: drop unnecessary clock flags
>>
>> changes since v5 at [6]: 
>>  - drop unnecessary header files
>>  - add 'axg_aoclk' prefix to clk driver, make them more consistent
>>  - add missing end new line..
>>
>> changes since v4 at [5]: 
>>  - fix return err
>>  - introduce CONFIG_COMMON_CLK_MESON_AO
>>  - format/style minor fix
>>
>> changes since v3 at [4]: 
>>  - add 'const' contraint to the read-only data
>>  - switch to devm_of_clk_add_hw_provider API
>>  - check return value of devm_reset_controller_register
>>
>> changes since v2 at [2]: 
>>  - rework meson_aoclkc_probe() which leverage the of_match_data
>>  - merge patch 5-6 into this series
>>  - seperate DTS patch, will send to Kevin Hilman independently
>>  
>> changes since v1 at [0]: 
>>  - rebase to clk-meson's branch 'next/drivers' [1]
>>  - fix license, update to BSD-3-Clause
>>  - drop un-used include header file
>>
>> [0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
>> [1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
>> [2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
>> [3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com
>> [4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan@amlogic.com
>> [5] https://lkml.kernel.org/r/20180408031938.153474-1-yixun.lan@amlogic.com
>> [6] https://lkml.kernel.org/r/20180409143749.71197-1-yixun.lan@amlogic.com
> 
> Yixun
> 
> Please :
>  - Fix checkpatch error in patch 5 
>  - Collect Philip's Ack on patch 4
I've fixed above two

>  - Remove the extra new lines at EOF in patch 2 (maybe others, I did not check
> them all) - 1 new line at the end of each file, not 2.
> 

but, I just go back and check the patch, couldn't find any file which
end with 2 new lines at EOF, could you point me out?


Yixun
