Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598FD21765
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598FD21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHHQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:10:20 -0400
Received: from muru.com ([72.249.23.125]:53106 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbeHHQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:10:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AC358805C;
        Wed,  8 Aug 2018 13:54:06 +0000 (UTC)
Date:   Wed, 8 Aug 2018 06:50:31 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com,
        t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Message-ID: <20180808135031.GT99251@atomide.com>
References: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
 <20180808065852.GO99251@atomide.com>
 <0f6601d6-5b14-8d1f-65db-2b8b5a50397d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6601d6-5b14-8d1f-65db-2b8b5a50397d@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* J, KEERTHY <j-keerthy@ti.com> [180808 13:14]:
> 
> 
> On 8/8/2018 12:28 PM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [180807 09:29]:
> > > The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> > > add the flag for all the other SoCs.
> > > 
> > > Reported-by: Tony Lindgren <tony@atomide.com>
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks Tony. Lokesh pointed out about am43x-epos. So will make a minor
> correction to this patch with compatible. I searched all the am4 boards &
> seems like ti,am43 is the most generic compatible cover am43x-epos as well.
> So i will retain your ack and send a v2 with am43 compatible changed to a
> more generic ti,am43.

OK makes sense to me thanks.

Tony
