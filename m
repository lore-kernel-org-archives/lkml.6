Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeEFDnO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 23:43:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:19497 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeEFDnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 23:43:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="39578948"
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, kan.liang@linux.intel.com
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
References: <20180425160008.3407-1-acme@kernel.org>
        <20180425160008.3407-6-acme@kernel.org>
        <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
        <20180503103717.GA14776@krava>
        <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
        <20180504160228.GA25229@krava>
Date: Sat, 05 May 2018 20:43:11 -0700
In-Reply-To: <20180504160228.GA25229@krava> (Jiri Olsa's message of "Fri, 4
        May 2018 18:02:28 +0200")
Message-ID: <87a7tdphyo.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:

Please fix this quickly, PT is currently totally non functional in Linus
mainline.

-Andi
