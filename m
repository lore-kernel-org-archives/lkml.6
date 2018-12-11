Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FCDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4571120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4571120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbeLKQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:43:41 -0500
Received: from muru.com ([72.249.23.125]:57474 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbeLKQnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:43:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3D9FD8027;
        Tue, 11 Dec 2018 16:43:43 +0000 (UTC)
Date:   Tue, 11 Dec 2018 08:43:36 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felix Brack <fb@ltec.ch>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Message-ID: <20181211164336.GV6707@atomide.com>
References: <20181210132448.7865-1-fb@ltec.ch>
 <20181211163618.GU6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211163618.GU6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181211 16:36]:
> * Felix Brack <fb@ltec.ch> [181210 05:25]:
> > Remove the unnecessary properties #address-cells and #size-cells
> > of node pinmux as there are no child-nodes with property reg.
> 
> Applying into omap-for-v4.21/dt thanks.

Actually this currently conflicts with the pending
am33xx l4 ti-sysc changes, so let's wait on this
one to avoid causing merge conflicts between
branches.

So dropping for now.

Regards,

Tony
