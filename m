Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IevjGSkzGlujUgAAmS7hNA
	; Fri, 08 Jun 2018 07:41:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7AE29607E4; Fri,  8 Jun 2018 07:41:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB06160590;
	Fri,  8 Jun 2018 07:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB06160590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeFHHlu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:41:50 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:41253 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751195AbeFHHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:41:49 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RC1nfnIqCtLaARC1qfxXOl; Fri, 08 Jun 2018 09:41:47 +0200
Subject: Re: [PATCH v10 4/4] [media] platform: Add Synopsys DesignWare HDMI RX
 Controller Driver
To: Jose Abreu <Jose.Abreu@synopsys.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Philippe Ombredanne <pombredanne@nexb.com>
References: <cover.1513013948.git.joabreu@synopsys.com>
 <5f9eedfd6f91ed73ef0bb6d3977588d01478909f.1513013948.git.joabreu@synopsys.com>
 <108e2c3c-243f-cd67-2df7-57541b28ca39@xs4all.nl>
 <635e7d70-0edb-7506-c268-9ebbae1eb39e@synopsys.com>
 <ca5b3cf7-c7d0-36d4-08ac-32a7a00afd7d@xs4all.nl>
 <f5341c4b-43e2-12f6-9c9f-2385d47bb2fd@synopsys.com>
 <86a5787d-6ed6-7674-35f9-c77341b4c36b@xs4all.nl>
 <3c15b537-33b3-f786-369e-5d82ab9eeb9c@synopsys.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ed3dabc0-66b2-d069-99f9-75b742709e9f@xs4all.nl>
Date: Fri, 8 Jun 2018 09:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3c15b537-33b3-f786-369e-5d82ab9eeb9c@synopsys.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLnkcEXQ+27UsnfZYQZI21+kMBxrjulWiA/PnHE3QCHIUeitIWa8qv67AYjt84M5Z39DGstdOONFhs0erqr4HDjQmw/vKX6d77Petz8uelYLACfiOrij
 Z+6ogN6zctWRKnkjMFxf+vTqDHjNeIFBlqWveXWjC5CpVz4ZwDD2aJ2h/mRuFFgCH4kORC48b+bRzNEftI7GY7lqAXSAG9EGMzwGTEF5IF7WXkNbHTipm25z
 api0r7+OFTIJB4mHJGBEFhZd5Iv5InLhsnVZ6dyTVWJijt2GGh7ylAvaUBeueNLRe+klr6dWVxgKqdBSvpNutt5ZeK4awNrrAkOX0FFu/WWj6dJLi/gFsf6f
 tO2NEXKqW2+fz+vk8LAL2tfOPLnVCNVHiiR8kOHkBqE+OmZ87KCtuEM+M7Y3L+J/YZAp9rymbf34qQw2o/6JUCd57MMXGMkN6ka12JlJz1OAiH/OxUU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

I have not seen any updates for this series. What is the status? I thought we
were close to merging this...

Regards,

	Hans

On 12/15/2017 12:23 PM, Jose Abreu wrote:
> Hi Hans,
> 
> On 13-12-2017 20:49, Hans Verkuil wrote:
>> On 13/12/17 15:00, Jose Abreu wrote:
>>>
>>> Indeed. I compared the values with the spec and they are not
>>> correct. Even hsync is wrong. I already corrected in the code the
>>> hsync but regarding interlace I'm not seeing an easy way to do
>>> this without using interrupts in each vsync because the register
>>> I was toggling does not behave as I expected (I misunderstood the
>>> databook). Maybe we should not detect interlaced modes for now?
>>> Or not fill the il_ fields?
>> As I mentioned above you as long as you get a good backporch value you
>> can deduce from whether it is an odd or even number to which field it
>> belongs and fill in the other values. So I think you only need to read
>> these values for one field.
>>
>> Filling in good values here (at least as far as is possible since not all
>> hardware can give it) will help debugging issues, even if you otherwise do
>> not support interlaced.
> 
> Ok, I will fill the fields.
> 
> Until the end of January I will be quite busy in another project
> so if you could review the remaining patches of this series I
> would appreciate very much ... This way when I have the time I
> can code all the changes and send them at once.
> 
> Thanks and Best Regards,
> Jose Miguel Abreu
> 
>>
>> Regards,
>>
>> 	Hans
> 
> 
