Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758149AbeD0Mby (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:31:54 -0400
Received: from omr-a005e.mx.aol.com ([204.29.186.50]:62283 "EHLO
        omr-a005e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeD0Mbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:31:52 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
 <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
 <57ea75b8-cebd-0ca2-0e4e-acf2beb6e981@aim.com>
 <a9448c11-2843-c82f-34d3-e9c96db346cf@linux.ibm.com>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <0c524e59-d30f-de36-8622-5b756a666665@aim.com>
Date: Fri, 27 Apr 2018 08:31:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <a9448c11-2843-c82f-34d3-e9c96db346cf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1afc0d5ae318356574
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/27/18 03:55, Thomas-Mich Richter wrote:
> On 04/26/2018 05:26 PM, Martin Vuille wrote:
>>
>> On 04/26/18 04:09, Thomas-Mich Richter wrote:
>>> was different. With you patch it changed from /usr/lib64/libc.so (old) to
>>> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
>>>
>> Thomas,
>>
>> Can you tell me what 'file' reports for the old and new files?
>>
>> Regards,
>> MV
>>
> Martin,
>
> not sure I understand your question:
>
> Before your patch the file which was picked by dwarf was
> /usr/lib64/libc.so
>
>
> With your patch file which was picked by dwarf was
> /usr/lib/debug/lib64/libc-2.26.so.debug
>
> Was this your question?
Thomas,

Apologies for being unclear in my request.

I was asking what the commands "file /usr/lib64/libc.so"
and "file /usr/lib/debug/lib64/libc-2.26.so.debug" report.

MV
