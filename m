Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934425AbeE1Vxr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:53:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52721 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934403AbeE1Vxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:53:43 -0400
X-Google-Smtp-Source: AB8JxZrnHhPOOF87OG8OYP2SJtOLPEMH5fPA0of+S5O/xbSfvZpXPt5km4jQtRwsqXTFrTxgnsDsrG/9R/l/9Z/QxSk=
MIME-Version: 1.0
In-Reply-To: <20180528200326.GJ25467@kernel.org>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org> <20180528200326.GJ25467@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 28 May 2018 15:53:42 -0600
Message-ID: <CANLsYkzn5qyzjxMiCPQ1GxyNjhHJp-2H6Lds11HP9rG5xug0FA@mail.gmail.com>
Subject: Re: [RFT v3 0/4] Perf script: Add python script for CoreSight trace disassembler
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Walker <Robert.Walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>, Kim Phillips <kim.phillips@arm.co>,
        Tor Jeremiassen <tor@ti.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2018 at 14:03, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Em Mon, May 28, 2018 at 04:44:59PM +0800, Leo Yan escreveu:
>> This patch series is to support for using 'perf script' for CoreSight
>> trace disassembler, for this purpose this patch series adds a new
>> python script to parse CoreSight tracing event and use command 'objdump'
>> for disassembled lines, finally this can generate readable program
>> execution flow for reviewing tracing data.
>>
>> Patch 0001 is one fixing patch to generate samples for the start packet
>> and exception packets.
>>
>> Patch 0002 is the prerequisite to add addr into sample dict, so this
>> value can be used by python script to analyze instruction range.
>>
>> Patch 0003 is to add python script for trace disassembler.
>>
>> Patch 0004 is to add doc to explain python script usage and give
>> example for it.
>>
>> This patch series has been rebased on acme git tree [1] with the commit
>> 19422a9f2a3b ("perf tools: Fix kernel_start for PTI on x86") and tested
>> on Hikey (ARM64 octa CA53 cores).
>
> Thanks, applied to perf/core.

Please hold off on that Arnaldo - I'm currently reviewing the set and
I think some things can be improved.

Thanks,
Mathieu

>
> - Arnaldo
