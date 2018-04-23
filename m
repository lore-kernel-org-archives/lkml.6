Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeDWO2P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755110AbeDWO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:28:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16022178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 11:28:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2/9] perf check-headers.sh: Add support to check 2
 independent files
Message-ID: <20180423142811.GE30324@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423090823.32309-3-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 23, 2018 at 11:08:16AM +0200, Jiri Olsa escreveu:
> Adding check_2 function to check 2 different files,
> the check function stays to check files that differs
> only in the prefix path.

Applied 1/9 and 2/9 to perf/core.

- Arnaldo
