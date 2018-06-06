Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cealov+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF36160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeFFMpn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeFFMpl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:45:41 -0400
Date: Wed, 6 Jun 2018 09:45:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/3] perf script python: Add more PMU fields
Message-ID: <20180606124538.GD24381@kernel.org>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
 <20180601015501.GI30764@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601015501.GI30764@tassilo.jf.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 31, 2018 at 06:55:01PM -0700, Andi Kleen escreveu:
> On Fri, Jun 01, 2018 at 05:01:00PM +0800, Jin Yao wrote:
> > When doing pmu sampling and then running a script with
> > perf script -s script.py, the process_event function gets
> > dictionary with some fields from the perf ring buffer
> > (like ip, sym, callchain etc).
> > 
> > But we miss quite a few fields we report now, for example,
> > LBRs,data source,weight,transaction,iregs,uregs,and etc.
> > 
> > This patch adds these fields for perf script python.
> 
> Patches look good to me.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo
