Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeDKRKr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:10:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:10:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D873560AFB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
 <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
Date: Wed, 11 Apr 2018 13:10:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2018 5:43 PM, Sinan Kaya wrote:
> On 4/6/2018 5:26 PM, James Hogan wrote:
>> On Fri, Apr 06, 2018 at 02:15:57PM -0400, Sinan Kaya wrote:
>>> On 4/5/2018 9:34 PM, Sinan Kaya wrote:
>>>> Can we get these merged to 4.17? 
>>>>
>>>> There was a consensus to fix the architectures having API violation issues.
>>>> https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html
>>>>
>>>>
>>>
>>> Any news on the MIPS front? Is this something that Arnd can merge? or does it have
>>> to go through the MIPS tree.
>>
>> It needs some MIPS input really. I'll try and take a look soon. Thanks
>> for the nudge.
>>
>>> It feels like the MIPS is dead since nobody replied to me in the last few weeks on
>>> a very important topic.
>>
>> Not dead, just both maintainers heavily distracted by real life right
>> now (which sadly, for me at least, trumps this very important topic) and
>> doing the best they can given the circumstances.
> 
> Thanks for the reply. Glad to hear somebody cares.


How is the likelihood of getting this fixed on 4.17 kernel? There was an agreement
to fix all architectures. MIPS is the only one left.

> 
>>
>> Cheers
>> James
>>
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
