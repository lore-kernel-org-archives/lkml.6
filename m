Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeELVLL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:11:11 -0400
Received: from vern.gendns.com ([206.190.152.46]:53982 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeELVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:11:09 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v10_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180509172606.29387-1-david@lechnology.com>
 <45ce3129-4a9e-54d2-e594-49b451571842@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <0b62ac7b-aa02-6641-2a02-6cefb4076262@lechnology.com>
Date: Sat, 12 May 2018 16:11:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <45ce3129-4a9e-54d2-e594-49b451571842@ti.com>
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

On 05/11/2018 10:26 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 3 patches fix some issues with the clock
>> drivers that have already been accepted into the mainline kernel.
> 
> I have not yet looked at the patches, but I got a bunch of W=1 warnings
> and some sparse warnings when building your branch. Please take a look
> at these. Unfortunately the output is mixed between sparse and compiler.
> The "expression using sizeof(void)" can be ignored as its a known issue
> with sparse, I believe.
> 

I've started a common-clk-v11 branch on my GitHub that fixes most of these.
Also submitted "clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups" that
fixes a couple more. I've purposely not fixed the davinci_clk_reset_* functions
since there is already a patch that will remove those functions in the future.

I'll wait a bit longer for DT review before re-sending v11 of this series.
