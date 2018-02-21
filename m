Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936589AbeBUOh6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934187AbeBUOhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:37:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18B5214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Feb 2018 11:37:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf, tools, stat: Use xyarray dimensions to iterate
 fds
Message-ID: <20180221143750.GD24416@kernel.org>
References: <20171006020029.13339-1-andi@firstfloor.org>
 <20180221143311.GC2565@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221143311.GC2565@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 21, 2018 at 03:33:11PM +0100, Jiri Olsa escreveu:
> On Thu, Oct 05, 2017 at 07:00:28PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Now that the xyarray stores the dimensions we can use those
> > to iterate over the FDs for a evsel.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied, and also sorry for having overlooked this :-\

- Arnaldo
