Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C09BC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A9E2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A9E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGQxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:53:41 -0500
Received: from mail.gnudd.com ([77.43.112.34]:57152 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:53:40 -0500
X-Greylist: delayed 834 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2018 11:53:39 EST
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id wB7Gdglf009439;
        Fri, 7 Dec 2018 17:39:42 +0100
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id wB7GdfWQ009437;
        Fri, 7 Dec 2018 17:39:41 +0100
Date:   Fri, 7 Dec 2018 17:39:41 +0100
From:   Alessandro Rubini <rubini@gnudd.com>
To:     paul.gortmaker@windriver.com
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        ciminaghi@gnudd.com
Subject: Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181207163941.GA9430@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20181203150756.GA23156@windriver.com>
References: <20181203150756.GA23156@windriver.com>
  <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
  <1543811009-15112-13-git-send-email-paul.gortmaker@windriver.com>
  <20181203111442.GK26661@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] mfd: sta2x11: drop unused MODULE_ tags from non-modular code

Acked-by: Alessandro Rubini <rubini@gnudd.com>

> Alessandro, Davide - you can find additional context regarding why we
> are making these changes in the [00/22] e-mail that can be found here:
> https://lore.kernel.org/lkml/1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com/

Thanks a lot for this extra link. Yes, I agree.

I set up this as a module because /sys/modules has much more than what
is actually a module, and the "module" concept brings it the idea
of module parameters, that are available for built-in code too, with
the module namespace.  But it's actually not used in this case.

Thanks
/alessandro
