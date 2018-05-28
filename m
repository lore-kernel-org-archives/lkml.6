Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbeE1UDd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933699AbeE1UD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:03:29 -0400
Date: Mon, 28 May 2018 17:03:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Walker <Robert.Walker@arm.com>, mike.leach@linaro.org,
        kim.phillips@arm.co, Tor Jeremiassen <tor@ti.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [RFT v3 0/4] Perf script: Add python script for CoreSight trace
 disassembler
Message-ID: <20180528200326.GJ25467@kernel.org>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 28, 2018 at 04:44:59PM +0800, Leo Yan escreveu:
> This patch series is to support for using 'perf script' for CoreSight
> trace disassembler, for this purpose this patch series adds a new
> python script to parse CoreSight tracing event and use command 'objdump'
> for disassembled lines, finally this can generate readable program
> execution flow for reviewing tracing data.
> 
> Patch 0001 is one fixing patch to generate samples for the start packet
> and exception packets.
> 
> Patch 0002 is the prerequisite to add addr into sample dict, so this
> value can be used by python script to analyze instruction range.
> 
> Patch 0003 is to add python script for trace disassembler.
> 
> Patch 0004 is to add doc to explain python script usage and give
> example for it.
> 
> This patch series has been rebased on acme git tree [1] with the commit
> 19422a9f2a3b ("perf tools: Fix kernel_start for PTI on x86") and tested
> on Hikey (ARM64 octa CA53 cores).

Thanks, applied to perf/core.

- Arnaldo
