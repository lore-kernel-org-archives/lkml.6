Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeBGPJx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:09:53 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:51975 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754151AbeBGPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:09:52 -0500
X-Google-Smtp-Source: AH8x227Hah/UbEmP2C+/cc4vq0Lho+e1J3Y7A13yejohD61xBC9rrJvvG8QanXZPvA7QpDrJU99YtA==
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vladislav Valtchev <vladislav.valtchev@gmail.com>,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
References: <20180204032014.6962-1-sztsian@gmail.com>
 <20180204032014.6962-2-sztsian@gmail.com>
 <20180206181807.2d35393e@gandalf.local.home>
 <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
 <20180207094017.5a130e6a@gandalf.local.home>
From: Zamir SUN <sztsian@gmail.com>
Message-ID: <ca3062ba-7f87-dbf2-a50f-9d9bdb421159@gmail.com>
Date: Wed, 7 Feb 2018 23:09:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207094017.5a130e6a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 10:40 PM, Steven Rostedt wrote:
> On Wed, 7 Feb 2018 22:01:46 +0800
> Zamir SUN <sztsian@gmail.com> wrote:
> 
> 
>> Thanks for the heads-up! I did not see that before.
>>
>> While just a note for this, in Fedora 27:
>>
>> $ if command -v swig; then echo 1; else echo 0; fi
>> /usr/bin/swig
>> 1
>>
>> Actually this test has the same problem as of `which swig` - When swig
>> exists, the var SWIG_DEFINED will not be 1 (as shown above).
>>
>> I see Vladislav is already on this thread. I hope this can be fixed
>> before merging the patch set.
>>
> 
> After doing some more testing, I'm going to push out the changes today.
> Would you be able to add patches on top of the changes? We are doing a
> restructuring of the directory such that it can grow more.
> 
> I'll be backporting these fixes to 2.6 and 2.7 as well.
> 

Sure, I will rebase after Vladislav's patch set is merged.

Thanks!


-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
