Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033707AbeBOOzR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033438AbeBOOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:55:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE62E217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:55:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Miscellaneous fix from the previous cycle
Message-ID: <20180215145512.GC30974@kernel.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 12, 2018 at 01:32:34PM -0700, Mathieu Poirier escreveu:
> Good day Arnaldo,
> 
> Here are 3 patches that were sent late in the v4.15 cycle, too late for
> you to pick up for the v4.16 cycle.  I don't know if they are on a backlog
> of yours somewhere or if you've made a mental note of them - if so kindly
> disregard this set.  Otherwise, here they are again, rebased to your latest
> perf/core [1].
> 
> All 3 patches are required for proper functionning of the CoreSight
> trace decoding integration that is in the current cycle.

Thanks, applied the 3 patches.

- Arnaldo
