Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8F0EFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E089208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E089208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeFLPAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:00:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56032 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeFLPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:00:49 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 472041a5c86a8756; Tue, 12 Jun 2018 17:00:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Suman Anna <s-anna@ti.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ti-cpufreq: minor fixes/cleanups
Date:   Tue, 12 Jun 2018 16:59:46 +0200
Message-ID: <3941876.itVUMqcnQG@aspire.rjw.lan>
In-Reply-To: <20180531222144.26739-1-s-anna@ti.com>
References: <20180531222144.26739-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 1, 2018 12:21:42 AM CEST Suman Anna wrote:
> Hi Rafael,
> 
> This is a repost of the v2 patches Ccing the proper linux-pm list.
> There are no code changes, I have picked up Viresh's acks and
> also added the stable kernel versions the first patch needs to be
> applied to.
> 
> regards
> Suman
> 
> v2: https://marc.info/?l=linux-omap&m=152268780921259&w=2
> v1: https://patchwork.kernel.org/patch/10308925/
> 
> Suman Anna (2):
>   cpufreq: ti-cpufreq: Fix an incorrect error return value
>   cpufreq: ti-cpufreq: Use devres managed API in probe()
> 
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> 

Applied, thanks!


