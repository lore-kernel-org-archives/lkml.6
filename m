Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBJVuL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:50:11 -0500
Received: from fallback10.m.smailru.net ([94.100.178.50]:37349 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752335AbeBJVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:50:10 -0500
Subject: Re: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
To: Philipp Rossak <embed3d@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180209175236.21215-1-embed3d@gmail.com>
 <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
 <d3fcc9d2-f2e6-189c-529f-890f2afdd837@gmail.com>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <40887d4b-0fb0-239e-e5a9-1a87f82946c2@orpaltech.com>
Date: Sun, 11 Feb 2018 00:08:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d3fcc9d2-f2e6-189c-529f-890f2afdd837@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A5E292B4E19A5AB189E1414E4AB6365794FA5D384A4654657D725E5C173C3A84C3AA93A90EDF72B4348085B9334FF657296D8C47C27EEC5E9FB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849175A8CC510BFCB672A30CB6E2AEAB65E61069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5D1E44DACA11ACF431E388A54F2264568985958D3EF2919B0462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005EBA3FDA8F7473FBD423CA1578F74017BE447542D53D8BFF7134B2017C7F24A7E5FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 12:01 AM, Philipp Rossak wrote:
> Hey Sergey,
>
> Thanks for mentioning, but I think the problem has nothing to do with 
> those patches. I tested them with the v4.15.0 Kernel since this is the 
> last stable release and we are right now in the merging window.
>
> I tested the latest mainline, without those patches and the kernel is 
> not booting (I can't see any uart output).
>
> Thanks,
> Philipp
>
> On 10.02.2018 14:56, Sergey Suloev wrote:
>> On 02/09/2018 08:52 PM, Philipp Rossak wrote:
>>> This patchseries fixes the bananapi m1 devicetree, to be able to 
>>> boot again.
>>> The first two patches update/improve the devicetree and the last 
>>> patch adds
>>> all missing regulators.
>>>
>>> Regards,
>>> Philipp
>>>
>>> Philipp Rossak (3):
>>>    arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
>>>    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>>>    arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
>>>
>>>   arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 
>>> +++++++++++++++++++++++-
>>>   1 file changed, 67 insertions(+), 3 deletions(-)
>>>
>> patches are not working
>>
>> Thanks
>>
same problem, but after applying the patches my device is till hanging.
