Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E741C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeGJGRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:17:51 -0400
Received: from muru.com ([72.249.23.125]:50926 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeGJGRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:17:46 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2DF3F8022;
        Tue, 10 Jul 2018 06:20:49 +0000 (UTC)
Date:   Mon, 9 Jul 2018 23:17:43 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     t-kristo@ti.com, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: sleep33/43xx: Make sleep actions
 configurable
Message-ID: <20180710061743.GH99251@atomide.com>
References: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180709 00:36]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add an argument to the sleep33xx and sleep43xx code to allow us to set
> flags to determine which portions of the code get called in order to use
> the same code for multiple power saving modes. This patch allows us to
> decide whether or not we flush and disable caches, save EMIF context,
> put the memory into self refresh and disable the EMIF, and/or invoke
> the wkup_m3 when entering into WFI.

Thanks applying both into omap-for-v4.19/soc.

Tony
