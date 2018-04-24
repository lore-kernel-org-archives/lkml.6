Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeDXT3c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDXT3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:29:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7CC21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 24 Apr 2018 16:29:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
Subject: Re: [PATCH 4/5] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180424192928.GE4427@kernel.org>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
 <1524594014-79243-4-git-send-email-kan.liang@linux.intel.com>
 <20180424191721.GB4427@kernel.org>
 <9a2070b4-9a27-4e38-f235-2d44ae39dd1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2070b4-9a27-4e38-f235-2d44ae39dd1f@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 24, 2018 at 03:23:06PM -0400, Liang, Kan escreveu:
> On 4/24/2018 3:17 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 24, 2018 at 11:20:13AM -0700, kan.liang@linux.intel.com escreveu:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Perf stat doesn't count the uncore event aliases from the same uncore
> > > block in a group, for example:
> > 
> > This one is not applying to acme/perf/urgent, all the rest I got merged
> > there, the last one with that change from using strstr() to a new bool
> > in perf_evsel for the uniquifying operation having being performed.
> 
> Sure. Thank you for letting me know.

Just pushed what I have there,

- Arnaldo
