Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBAVwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:52:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeBAVwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:52:18 -0500
Subject: Re: [PATCH] perf vendor events aarch64: Add JSON metrics for ARM
 Cortex-A53 Processor
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
References: <20180131032813.9564-1-wcohen@redhat.com>
 <20180201144309.GA4835@kernel.org>
 <3bebcee1-102c-34ec-880a-722d96062a39@redhat.com>
 <20180201205129.GC4835@kernel.org>
From: William Cohen <wcohen@redhat.com>
Message-ID: <c0d905c6-948d-98b1-85ca-5aa8b5090435@redhat.com>
Date: Thu, 1 Feb 2018 16:52:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201205129.GC4835@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 03:51 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 01, 2018 at 10:12:59AM -0500, William Cohen escreveu:
>> On 02/01/2018 09:43 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jan 30, 2018 at 10:28:13PM -0500, William Cohen escreveu:
>>>> Add JSON metrics for ARM Cortex-A53 Processor
>>>
>>> Hi Will, would it be possible to you include an URL for the document
>>> that served as a reference to you to write these files? Did you use some
>>> script?
>>
>> Hi Arnaldo,
>  
>> I can certainly add the reference to section "12.9 Events" of the ARM
>> Cortex -A53 MPCore Processor Revision: r0p4 Technical Reference Manual
>> to the patch.  That would be useful for people to know where to look
>> for additional information about the events.
> 

Hi Arnaldo,

The ARM Cortex A53 manual is available at:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0500g/DDI0500G_cortex_a53_trm.pdf

It would probably be useful to include that URL in the commit information to make it easier for people to look up the information.

-Will

> I'll take these clarifications and add it to your patch, that I am
> applying now, please let me know if you have anything else to add and
> I'll ammend it if I get it before I send it upstream.
>  
>> Unlike the Intel processors there isn't a script that automatically
>> generated these files. The patch was manually generated from the
>> documentation and the previous oprofile ARM Cortex ac53 event file
>> patch I made.
> 
> Thanks a lot for this extra information,
> 
> - Arnaldo
> 
