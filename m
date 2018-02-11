Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeBKH3l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 02:29:41 -0500
Received: from smtp54.i.mail.ru ([217.69.128.34]:36400 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeBKH3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 02:29:40 -0500
Subject: Re: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
To: Philipp Rossak <embed3d@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180209175236.21215-1-embed3d@gmail.com>
 <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
 <d3fcc9d2-f2e6-189c-529f-890f2afdd837@gmail.com>
 <40887d4b-0fb0-239e-e5a9-1a87f82946c2@orpaltech.com>
 <da8909da-4eea-0fdf-e104-4442f7986455@gmail.com>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <cfdd543b-9a50-002e-34af-d611aca4d1a6@orpaltech.com>
Date: Sun, 11 Feb 2018 10:29:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <da8909da-4eea-0fdf-e104-4442f7986455@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5BC1F3BC8E5AA044163354A52B7DE2B52A44FE853E7C7335B725E5C173C3A84C37725542EFDE5E0D3C22B5DD7A29F214264E4DC1543031AB7C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849171D4D7C4E371099F73828BB1A0B5EF40A069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 01:07 AM, Philipp Rossak wrote:
>
>
> On 10.02.2018 22:08, Sergey Suloev wrote:
>> On 02/11/2018 12:01 AM, Philipp Rossak wrote:
>>> Hey Sergey,
>>>
>>> Thanks for mentioning, but I think the problem has nothing to do 
>>> with those patches. I tested them with the v4.15.0 Kernel since this 
>>> is the last stable release and we are right now in the merging window.
>>>
>>> I tested the latest mainline, without those patches and the kernel 
>>> is not booting (I can't see any uart output).
>>>
>>> Thanks,
>>> Philipp
>>>
>>> On 10.02.2018 14:56, Sergey Suloev wrote:
>>>> On 02/09/2018 08:52 PM, Philipp Rossak wrote:
>>>>> This patchseries fixes the bananapi m1 devicetree, to be able to 
>>>>> boot again.
>>>>> The first two patches update/improve the devicetree and the last 
>>>>> patch adds
>>>>> all missing regulators.
>>>>>
>>>>> Regards,
>>>>> Philipp
>>>>>
>>>>> Philipp Rossak (3):
>>>>>    arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
>>>>>    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>>>>>    arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
>>>>>
>>>>>   arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 
>>>>> +++++++++++++++++++++++-
>>>>>   1 file changed, 67 insertions(+), 3 deletions(-)
>>>>>
>>>> patches are not working
>>>>
>>>> Thanks
>>>>
>> same problem, but after applying the patches my device is till hanging.
>>
>>
> Can you please share a bootlog? Here is mine [1]. As you can see I'm 
> able to boot.
> I build it with this branch [2]. For testing you should replace the 
> dtb and the uImage/zImage
>
> Philipp
>
>
> [1]: https://pastebin.com/mVjv3LDf
> [2]: 
> https://github.com/embed-3d/linux/tree/testing/bpi-m2-regulator-test-2

I am going to test it and come back with outcome

Thanks
