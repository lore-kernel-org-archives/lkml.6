Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeCGKEQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:04:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751127AbeCGKEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:04:11 -0500
Date: Wed, 7 Mar 2018 11:04:08 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V3 0/3] perf stat: improvements for handling of multiple
 PMUs
Message-ID: <20180307100408.GA22848@krava>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:04:41AM -0500, Agustin Vega-Frias wrote:
> This series of patches adds some simple improvements to the way perf stat
> handles PMUs that have multiple instances by:
> 
> 1. Adding glob-like matching in addition to the prefix-based matching
>    introduced previously (patch 1).
> 2. Adding the ability to recover the PMU names when printing the events
>    separately with the --no-merge option (patch 2).
> 3. Restoring auto-merge for events created by prefix or glob-like match
>    (patch 3). Note that this still keeps the behavior that disables
>    auto-merging of legacy symbolic events (e.g. cycles).
> 
> V3:
> 
> - Consolidated prefix and glob matching into a single glob match with a
>   trailing * to maintain prefix matching and have more consistent behavior.
>   E.g., all of these match all the uncore_imc PMUs: imc, imc*, *imc, *imc*

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
