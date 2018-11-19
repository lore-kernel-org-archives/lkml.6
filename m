Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC72C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B22146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52B22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeKTFBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:01:30 -0500
Received: from muru.com ([72.249.23.125]:54612 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeKTFBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:01:30 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A4D7A80B6;
        Mon, 19 Nov 2018 18:36:45 +0000 (UTC)
Date:   Mon, 19 Nov 2018 10:36:41 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com,
        t-kristo@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: ti: wkup_m3: Add PRCM int16 as the wake up source
Message-ID: <20181119183641.GY53235@atomide.com>
References: <1541999860-14550-1-git-send-email-j-keerthy@ti.com>
 <99b2658c-2394-0660-6f63-0ef63a7c30f3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b2658c-2394-0660-6f63-0ef63a7c30f3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@oracle.com> [181113 18:51]:
> On 11/11/2018 9:17 PM, Keerthy wrote:
> > Add PRCM int16 as the wake up source.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> Looks good.
> 
> Tony, Would you able to pick this up ?

Sure, aplying into omap-for-v4.21/driver thanks.

Tony
