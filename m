Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCMPXr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:23:47 -0400
Received: from omr-a008e.mx.aol.com ([204.29.186.51]:58473 "EHLO
        omr-a008e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeCMPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:23:23 -0400
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support for
 ARM64
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "Christian Hansen (chansen3)" <chansen3@cisco.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Vuille, Martin (Martin)" <vmartin@avaya.com>
References: <A5E405FE-1BA3-46FC-9A43-CF19A4B369C5@cisco.com>
 <20180226142726.cd413c792d0782f77b60a23e@arm.com>
 <20180226174040.6998bd3c0a79b2f19c491e4d@arm.com>
 <9B701F46-6AEA-48D8-9103-71D35C83776D@cisco.com>
 <20180308211030.4ee4a0d6ff6dc5cda1b567d4@arm.com>
 <20180309150627.GB8347@kernel.org>
 <20180309120720.9358515dbff3b1d1fdf70cc8@arm.com>
 <20180309182440.GA25111@kernel.org>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <3307bb0b-0257-9151-2b1c-95a6661ac5d4@aim.com>
Date: Tue, 13 Mar 2018 11:23:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180309182440.GA25111@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1add8d5aa7ece56490
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/18 13:24, Arnaldo Carvalho de Melo wrote:
>
>> - "perf unwind: Report error from dwfl_attach_state"
>>    https://patchwork.kernel.org/patch/10211483/
>>    [Martin, I guess it would help if you replied-all that patch and
>>     added your signed-off-by.]
> Right, the S-o-B is needed

S-o-B has been provided by reply to this email. If you prefer, I can
resubmit the patch with the S-o-B included.

>   
>> - "perf unwind: Unwind with libdw doesn't take symfs into account"
>>    https://patchwork.kernel.org/patch/10211599/
> This one has the S-o-B, applying, Jiri, holler if you disagree,
>
> - Arnaldo
>   

Thanks.

Regards,
MV
