Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBZD0X (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:26:23 -0500
Received: from cock.li ([185.100.85.212]:55388 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeBZD0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:26:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Feb 2018 03:26:18 +0000
From: thetruthbeforeus@firemail.cc
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property -- You wokr with japanese after they fucked you
In-Reply-To: <9938e4eb-45aa-bf68-dd64-bb0a23f99e3d@samsung.com>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com>
 <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
 <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
 <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
 <9938e4eb-45aa-bf68-dd64-bb0a23f99e3d@samsung.com>
Message-ID: <5f9c516ebf049dbd85df7e7378b64ad8@firemail.cc>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You all know that you're working with white and japanese mthr fuckers 
right? you just fine with that? After what they did to your people? Ok 
then. You be you. You be you.

Here's some real talk about the while mother fuckers:
https://www.liveleak.com/view?i=c34_1519605684

On 2018-02-26 02:07, Jaehoon Chung wrote:
> On 02/24/2018 01:16 AM, Andy Shevchenko wrote:
>> On Fri, Feb 23, 2018 at 4:19 PM, Shawn Lin <shawn.lin@rock-chips.com> 
>> wrote:
>>> On 2018/2/23 21:27, Andy Shevchenko wrote:
>>>> On Fri, Feb 23, 2018 at 8:41 AM, Jaehoon Chung 
>>>> <jh80.chung@samsung.com>
>>>> wrote:
>>>>> 
>>>>> 'clock-freq-min-max' property had already deprecated.
>>>>> Remove the 'clock-freq-min-max' property that is kept to maintain
>>>>> the compatibility.
>>>> 
>>>> 
>>>> Removing a property without telling the user what to expect is a bad
>>>> idea and ABI breakage.
>>>> 
>>> 
>>> What's the general process to remove a property?
>>> 
>>> I guess we should do:
>>> 1) deprecate it in the first place and remove it from all upstream DT
>>> 2) wait some long enough days for expecting the stale of all old DTB
>>> containing that property
>>> 3) remove the functionality of the deprecated property from the 
>>> driver
>>> but still leave some warning there
>>> 4) remove the left warning finally
>> 
>> I don't know. Perhaps Rob can shed a light here.
>> But I would really OK with removal of some of such properties from
>> some drivers where it's more burden to keep them.
> 
> This property had deprecated about 8months ago.
> I think that it was enough to keep this property for maintaining the
> compatibility.
> 
> I didn't remove this property without any alternative.
> 
> Best Regards,
> Jaehoon Chung
> 
>> 
>>> And for the ABI breakage, we should add something in 
>>> Documentation/ABI
>>> /obsolete  or Documentation/ABI/removed ?
>> 
