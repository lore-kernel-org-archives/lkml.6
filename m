Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbeCITRw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:17:52 -0500
Received: from omr-m008e.mx.aol.com ([204.29.186.7]:62026 "EHLO
        omr-m008e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbeCITRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:17:51 -0500
Subject: Re: [PATCH] perf tools arm64: Add libdw DWARF post unwind support for
 ARM64
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Christian Hansen (chansen3)" <chansen3@cisco.com>,
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
 <cde0e6f4-155f-3d7e-8d84-fd482f729976@aim.com>
 <20180309131508.54003466f8aedfafaee4e7a8@arm.com>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <b3b296cc-9d49-5ccf-9b23-2bfdaed63225@aim.com>
Date: Fri, 9 Mar 2018 14:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180309131508.54003466f8aedfafaee4e7a8@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1adece5aa2dddc3744
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, thought of doing that.

Unfortunately it was sent directly from git, so I do not have a copy of the message that was sent.

MV


On 03/09/18 14:15, Kim Phillips wrote:
> On Fri, 9 Mar 2018 13:49:50 -0500
> Martin Vuille <jpmv27@aim.com> wrote:
>
>> For https://patchwork.kernel.org/patch/10211483/, I'm not sure how to go about doing a reply to all.
> Hit reply-all from the copy in your Sent folder.
>
> Kim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
