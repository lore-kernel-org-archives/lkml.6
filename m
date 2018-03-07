Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeCGRJk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:09:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:14285 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbeCGRJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:09:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="22687811"
Date: Wed, 7 Mar 2018 09:09:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V3 0/3] perf stat: improvements for handling of multiple
 PMUs
Message-ID: <20180307170918.GJ25017@tassilo.jf.intel.com>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <20180307100408.GA22848@krava>
 <20180307133630.GD3701@kernel.org>
 <20180307135105.GA9080@krava>
 <20180307143004.GH3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307143004.GH3701@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, I have this applied to my local branch, and will add his acks or
> drop the patches if he still has any objection, Andi?

Patches looks good to me.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
