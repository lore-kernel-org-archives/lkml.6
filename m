Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0F420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeK3IrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:47:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:37036 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeK3IrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:47:13 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6B614145;
        Thu, 29 Nov 2018 21:40:23 +0000 (UTC)
Date:   Thu, 29 Nov 2018 14:40:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] Documentation: admin-guide: PM: Add cpuidle document
Message-ID: <20181129144022.0908ddb2@lwn.net>
In-Reply-To: <2021920.OpoCz8F1eI@aspire.rjw.lan>
References: <2021920.OpoCz8F1eI@aspire.rjw.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 22:22:04 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> Important information is missing from user/admin cpuidle documentation
> available today, so add a new user/admin document for cpuidle containing
> current and comprehensive information to admin-guide and drop the old
> .txt documents it is replacing.

I've not had a chance to read through it in depth, but a first scan looks
good.  I assume this is going up via your tree?

Thanks,

jon
