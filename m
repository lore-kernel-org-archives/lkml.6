Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBCMLS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 07:11:18 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.131]:24581 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751319AbeBCMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 07:11:09 -0500
Date: Sat, 03 Feb 2018 06:11:07 -0600
Message-ID: <20180203061107.Horde.dBz-aI7SC7ZqbG-NQQLPYhF@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
        Colin Leroy <colin@colino.net>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: macintosh: change some data types from int to bool
References: <20180124014228.GA26899@embeddedgus>
 <3zVGNG6B8Hz9t5Y@ozlabs.org>
 <20180129050920.Horde.QLe9K1M-r7blMvmzflyFRGC@gator4166.hostgator.com>
 <87shao8da3.fsf@concordia.ellerman.id.au>
In-Reply-To: <87shao8da3.fsf@concordia.ellerman.id.au>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1ehwex-0022xF-N5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:39385
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Quoting Michael Ellerman <mpe@ellerman.id.au>:

> "Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:
>
>> Hi Michael,
>>
>> Quoting Michael Ellerman <patch-notifications@ellerman.id.au>:
>>
>>> On Wed, 2018-01-24 at 01:42:28 UTC, "Gustavo A. R. Silva" wrote:
>>>> Change the data type of the following variables from int to bool
>>>> across all macintosh drivers:
>>>>
>>>> started
>>>> slots_started
>>>> pm121_started
>>>> wf_smu_started
>>>>
>>>> Some of these issues were detected with the help of Coccinelle.
>>>>
>>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>
>>> Applied to powerpc next, thanks.
>>>
>>> https://git.kernel.org/powerpc/c/4f256d561447c6e1bf8b70e19daae0
>>>
>>> cheers
>>
>> Awesome.
>>
>> If I can help out with anything else, please let me know.
>
> Sure thing.
>
> We have a TODO list of sorts on github, some of them are easy, some are
> not, feel free to ask here or on an individual issue for help:
>
>   https://github.com/linuxppc/linux/issues
>

I'm sorry for the late reply. I was addressing some issues on DRM and  
NET components.

I already took a look into the TODO list. I'll ask you about some of  
the issues on github.

Thanks!
--
Gustavo
