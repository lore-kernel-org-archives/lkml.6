Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBHPb7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:31:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeBHPb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:31:57 -0500
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Olsa <jolsa@redhat.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135423.GC10234@krava> <20180208140250.43a10b84@alans-desktop>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <ak@linux.intel.com>, <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <7d5b53dd-2e86-da0e-a7b6-9dd94ebcb49c@huawei.com>
Date: Thu, 8 Feb 2018 15:31:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180208140250.43a10b84@alans-desktop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 14:02, Alan Cox wrote:
> On Thu, 8 Feb 2018 14:54:23 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
>
>> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
>>
>> SNIP
>>
>>>  static void print_events_table_suffix(FILE *outfp)
>>>  {
>>>  	fprintf(outfp, "{\n");
>>> @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
>>>  	return event;
>>>  }
>>>
>>> +static void fixup_field(char *from, char **to)
>>> +{
>>> +	*to = malloc(strlen(from));
>>> +
>>> +	strcpy(*to, from);
>>> +}
>>
>> could you just call '*to = strdup(from)' in here?

Right

>
> And check for malloc returning NULL.
>

Right again,

> Alan
>

I should have concentrated on the coding as much as the feature being 
added...

Thanks,
John
> .
>
