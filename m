Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB557C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CC12082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CC12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeJ3QPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:15:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48732 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJ3QPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:15:01 -0400
Received: from 79.184.254.164.ipv4.supernova.orange.pl (79.184.254.164) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id f23f43da17d60b6c; Tue, 30 Oct 2018 08:22:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Mel Gorman' <mgorman@suse.de>,
        'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 30 Oct 2018 08:19:14 +0100
Message-ID: <1649954.HZZfnVZxCN@aspire.rjw.lan>
In-Reply-To: <001201d46dbf$88339510$989abf30$@net>
References: <001201d46dbf$88339510$989abf30$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 27, 2018 8:37:24 AM CET Doug Smythies wrote:
> This is just for anybody else trying to compile:
> 
> On 2018.10.26 02:12 Rafael J. Wysocki wrote:
> 
> > The venerable menu governor does some thigns that are quite
> 
> Typo: thigns -> things
> 
> ...[snip]...
> 
> > The patch should apply on top of 4.19, although I'm running it on
> > top of my linux-next branch.
> 
> No, it uses "poll_time_limit" which was introduced in patch 1 of 6
> [1] in that group of menu changes from October 2nd.
> 
> "[PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for polling state"

Right, sorry for missing that.

Thanks,
Rafael

