Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4620892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGMUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:20:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63655 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLGMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:20:29 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id fe7aad0d448779bc; Fri, 7 Dec 2018 13:20:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
Date:   Fri, 07 Dec 2018 13:20:13 +0100
Message-ID: <2696247.uWQGDES4iU@aspire.rjw.lan>
In-Reply-To: <20181207120203.ohc7icj5wf3gbwi3@queper01-lin>
References: <1688146.Dmze7u1T7F@aspire.rjw.lan> <20181207120203.ohc7icj5wf3gbwi3@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 7, 2018 1:02:05 PM CET Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 07 Dec 2018 at 12:57:00 (+0100), Rafael J. Wysocki wrote:
> > --- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
> >  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> > +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/high
> 
> That should be s/high/above I suppose.

Right, thanks for spotting this. :-)

> > +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/below
> 
> Other than that this seems really useful :-)

Thanks!

