Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757938AbeBPNCm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752691AbeBPNCl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:02:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95072175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 16 Feb 2018 10:02:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix memory corruption in --branch-history
 mode --branch-history
Message-ID: <20180216130236.GA24436@kernel.org>
References: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
 <20180213094551.GA26936@krava>
 <2bfe35a5-f671-90dc-4753-75c8b2215f30@linux.intel.com>
 <9b3483ae-a612-9d69-9671-4ddfea2c440e@linux.intel.com>
 <20180216075303.GD14831@krava>
 <20180216123619.GA9945@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216123619.GA9945@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 16, 2018 at 01:36:19PM +0100, Jiri Olsa escreveu:
> 
> here it is.. I think we want this change now to fix the crash, and
> some more fixes later to ensure that the branch stack code follows
> properly the logic of --max-stack, which is not the case now

Thanks, applied.

- Arnaldo
