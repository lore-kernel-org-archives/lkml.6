Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E3CC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C1920890
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C1920890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeGDKxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:53:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41131 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbeGDKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:53:31 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d66d2b52d7be9952; Wed, 4 Jul 2018 12:53:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 10/21] cpufreq: intel_pstate: use match_string() helper
Date:   Wed, 04 Jul 2018 12:52:06 +0200
Message-ID: <1610915.y2K1qFKfud@aspire.rjw.lan>
In-Reply-To: <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1633797.WhvbXNE1Nx@aspire.rjw.lan> <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 27, 2018 1:56:30 AM CEST Srinivas Pandruvada wrote:
> On Tue, 2018-06-26 at 17:23 +0200, Rafael J. Wysocki wrote:
> > On Thursday, May 31, 2018 1:11:15 PM CEST Yisheng Xie wrote:
> > > match_string() returns the index of an array for a matching string,
> > > which can be used instead of open coded variant.
> > > 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Patch applied, thanks!

