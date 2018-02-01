Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBAUvi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbeBAUvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:51:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE88821798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 1 Feb 2018 17:51:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH] perf vendor events aarch64: Add JSON metrics for ARM
 Cortex-A53 Processor
Message-ID: <20180201205129.GC4835@kernel.org>
References: <20180131032813.9564-1-wcohen@redhat.com>
 <20180201144309.GA4835@kernel.org>
 <3bebcee1-102c-34ec-880a-722d96062a39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bebcee1-102c-34ec-880a-722d96062a39@redhat.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 01, 2018 at 10:12:59AM -0500, William Cohen escreveu:
> On 02/01/2018 09:43 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 30, 2018 at 10:28:13PM -0500, William Cohen escreveu:
> >> Add JSON metrics for ARM Cortex-A53 Processor
> > 
> > Hi Will, would it be possible to you include an URL for the document
> > that served as a reference to you to write these files? Did you use some
> > script?
> 
> Hi Arnaldo,
 
> I can certainly add the reference to section "12.9 Events" of the ARM
> Cortex -A53 MPCore Processor Revision: r0p4 Technical Reference Manual
> to the patch.  That would be useful for people to know where to look
> for additional information about the events.

I'll take these clarifications and add it to your patch, that I am
applying now, please let me know if you have anything else to add and
I'll ammend it if I get it before I send it upstream.
 
> Unlike the Intel processors there isn't a script that automatically
> generated these files. The patch was manually generated from the
> documentation and the previous oprofile ARM Cortex ac53 event file
> patch I made.

Thanks a lot for this extra information,

- Arnaldo
