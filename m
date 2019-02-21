Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06611C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F382083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfBUQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:36:42 -0500
Received: from muru.com ([72.249.23.125]:40092 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBUQgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:36:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B5D3F80C8;
        Thu, 21 Feb 2019 16:36:51 +0000 (UTC)
Date:   Thu, 21 Feb 2019 08:36:38 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     David Miller <davem@davemloft.net>
Cc:     grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org,
        netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Message-ID: <20190221163638.GW15711@atomide.com>
References: <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
 <20190220210127.GU15711@atomide.com>
 <20190220.161831.2067856031892978.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220.161831.2067856031892978.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller <davem@davemloft.net> [190221 00:18]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 13:01:27 -0800
> 
> > What I can do is set up a separate branch with just this
> > patch on top of the dts changes that the arm-soc guys can
> > then merge towards the end of the merge cycle. If that
> > works for you, let me know and I'll do it.
> 
> Yes, it does work for me.

OK I've applied this patch into omap-for-v5.1/cpsw.

Thanks,

Tony
