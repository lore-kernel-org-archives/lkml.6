Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272B6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847F127C17
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847F127C17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935377AbeF2JHw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:07:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41492 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeF2JHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:07:50 -0400
Received: from 79.184.253.185.ipv4.supernova.orange.pl (79.184.253.185) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 40e3a7c6f6c56f50; Fri, 29 Jun 2018 11:07:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Date:   Fri, 29 Jun 2018 11:06:29 +0200
Message-ID: <2322281.e0L7xCS2Qb@aspire.rjw.lan>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 29, 2018 8:19:30 AM CEST Viresh Kumar wrote:
> Hi,
> 
> This series improves the OPP core (and a bit of genpd core as well) to
> support multiple phandles in the "required-opps" property, which are
> only used for multiple power-domains per device for now.
> 
> We still don't propagate the changes to master domains for the
> sub-domains, but this patchset is an important stepping stone for that
> to happen.
> 
> Tested on Hikey960 after faking some power domains for CPUs.

I'm assuming that this work will go in via OPP.

Thanks,
Rafael

