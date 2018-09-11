Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B42C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21FD206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21FD206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeIKPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:30:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64341 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeIKPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:30:40 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id 62433e51d58a770e; Tue, 11 Sep 2018 12:31:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Eero Tamminen <eero.t.tamminen@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, viresh.kumar@linaro.org,
        mgorman@techsingularity.net, currojerez@riseup.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date:   Tue, 11 Sep 2018 12:29:19 +0200
Message-ID: <2115864.0gBFVHkxzn@aspire.rjw.lan>
In-Reply-To: <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 3, 2018 5:10:27 PM CEST Eero Tamminen wrote:
> Hi,
> 
> On 31.08.2018 20:28, Srinivas Pandruvada wrote:
> ...
> > As per testing Eero Tamminen, the results are comparable to the patchset
> > https://patchwork.kernel.org/patch/10312259/
> > But he has to watch results for several days to check trend.
> 
> It's close, but there is some gap compared to Francisco's version.

It is unclear what exactly you are referring to without a link to the
patch.

Thanks,
Rafael

