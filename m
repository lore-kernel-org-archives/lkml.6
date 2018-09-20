Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045CC21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045CC21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeIUDvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:51:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55833 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbeIUDvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:51:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0CC3080749; Fri, 21 Sep 2018 00:05:57 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:05:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: Re: [PATCH 11/12][RFC v3] x86-32, hibernate: Set up temporary text
 mapping for 32bit system
Message-ID: <20180920220557.GM27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 15:43:22, Chen Yu wrote:
> From: Zhimin Gu <kookoo.gu@intel.com>
> 
> Set up the temporary text mapping for the final jump address
> so that the system could jump to the right address after all
> the pages have been copied back to their original address.
> 
> Back-port from 64bit system.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
