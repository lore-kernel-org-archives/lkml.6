Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeCTNxb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:53:31 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:12119 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbeCTNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:53:26 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v8_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
To: Stephen Boyd <sboyd@kernel.org>, David Lechner <david@lechnology.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4d6cc890-e948-6784-82bf-dac196804c07@ti.com>
Date: Tue, 20 Mar 2018 19:22:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tuesday 20 March 2018 06:23 AM, Stephen Boyd wrote:
> Quoting David Lechner (2018-03-15 19:52:16)
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 19 patches create new clock drivers
>> using the common clock framework. There are basically 3 groups of clocks -
>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
>> unique init data, which is the reason for so many patches.
> 
> Should I apply the first 19 patches to clk tree? Looking over them
> nothing stands out except for your self comment about the bad
> reviewed-by tag which I can remove.

I think it will be a good idea to go ahead merge the drivers/clk/ parts
for v4.17.

I have been traveling, and have not been able to review this version.
But I have closely reviewed previous versions. If there really are
issues, I am sure we can get follow-on patches to fix those.

But getting these into v4.17 will enable platform parts to come in
easily into v4.18

Thanks,
Sekhar
