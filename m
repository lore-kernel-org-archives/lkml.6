Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033637AbeBOO4V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033103AbeBOO4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:56:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F0A2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:56:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf-tools: cs-etm: Properly deal with cpu maps
Message-ID: <20180215145617.GD30974@kernel.org>
References: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 12, 2018 at 04:38:57PM -0700, Mathieu Poirier escreveu:
> This patch allows the CoreSight AUX info section to fit topologies where
> only a subset of all available CPUs are present, avoiding at the same time
> accessing the ETM configuration areas of CPUs that have been offlined.

Thanks, applied.

- Arnaldo
