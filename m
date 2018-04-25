Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeDYLhM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:37:12 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:55069 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeDYLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:37:05 -0400
X-Google-Smtp-Source: AIpwx48PtfH54lQGIq5+q56HMbgalu6WoUFSyHK0uDjAzlgtnDeQSmMRTsnn7fgoB4ym6lGhn5mHhA==
Subject: Re: [PATCH 0/6] soc: qcom: smem: bug fixes
To: Andy Gross <andy.gross@linaro.org>
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180410222542.29474-1-elder@linaro.org>
 <e4cc56de-71d9-4904-ab09-92fa079c956a@linaro.org>
 <20180425040728.GA12778@hector.attlocal.net>
From: Alex Elder <elder@linaro.org>
Message-ID: <fa630ea3-ec6e-76ee-a677-198c26b7fb49@linaro.org>
Date: Wed, 25 Apr 2018 06:37:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425040728.GA12778@hector.attlocal.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 11:07 PM, Andy Gross wrote:
> On Fri, Apr 20, 2018 at 07:11:41AM -0500, Alex Elder wrote:
>> On 04/10/2018 05:25 PM, Alex Elder wrote:
>>> This series contains mostly bug fixes to the Qualcomm shared memory
>>> ("smem") code.  Although the bugs are real, they have most likely
>>> never been observed.
>>>
>>> 					-Alex
>>
>> Ping?	-Alex
> 
> It's only been a couple of weeks =P  That said, I looked over all of these and
> they look reasonable.  I'd like Bjorn to take a look as well.

Thanks a lot.  I have another set of patches based on these and I've been
sitting on them.  I don't want to inundate the list.

I see Bjorn has given his OK on all of them (thanks Bjorn!), so I'll send
out my new ones today.

					-Alex

> Andy
> 
