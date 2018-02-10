Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBJVBg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:01:36 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42217 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeBJVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:01:33 -0500
X-Google-Smtp-Source: AH8x224915OoJcXNMxTuC8Y2N9bqWjoLtnSVUUSwguaIPCJIe7YA+eMk94iAz8SEZndwJGwfCkVMiA==
Subject: Re: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
To: Sergey Suloev <ssuloev@orpaltech.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180209175236.21215-1-embed3d@gmail.com>
 <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <d3fcc9d2-f2e6-189c-529f-890f2afdd837@gmail.com>
Date: Sat, 10 Feb 2018 22:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sergey,

Thanks for mentioning, but I think the problem has nothing to do with 
those patches. I tested them with the v4.15.0 Kernel since this is the 
last stable release and we are right now in the merging window.

I tested the latest mainline, without those patches and the kernel is 
not booting (I can't see any uart output).

Thanks,
Philipp

On 10.02.2018 14:56, Sergey Suloev wrote:
> On 02/09/2018 08:52 PM, Philipp Rossak wrote:
>> This patchseries fixes the bananapi m1 devicetree, to be able to boot 
>> again.
>> The first two patches update/improve the devicetree and the last patch 
>> adds
>> all missing regulators.
>>
>> Regards,
>> Philipp
>>
>> Philipp Rossak (3):
>>    arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
>>    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>>    arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
>>
>>   arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 
>> +++++++++++++++++++++++-
>>   1 file changed, 67 insertions(+), 3 deletions(-)
>>
> patches are not working
> 
> Thanks
> 
