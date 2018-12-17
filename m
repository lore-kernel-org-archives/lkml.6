Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF10C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590CB206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeLQLo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:44:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56060 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeLQLoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:44:25 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b0a42346165929a2; Mon, 17 Dec 2018 12:44:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Date:   Mon, 17 Dec 2018 12:44:00 +0100
Message-ID: <4562223.GN38KlamCS@aspire.rjw.lan>
In-Reply-To: <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
References: <20181205155751.15945-1-tiny.windzz@gmail.com> <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 6, 2018 5:20:25 AM CET Viresh Kumar wrote:
> On 05-12-18, 10:57, Yangtao Li wrote:
> > Delete a line of meaningless return and some useless blank lines. In a function
> > whose return type is void, returning on the last line is not required.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2:
> > -revert modify of MODULE_
> > -delete some blank lines
> > ---
> >  drivers/cpufreq/cpufreq-nforce2.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

