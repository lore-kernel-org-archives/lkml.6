Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55104C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139C72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139C72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJEV3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:29:04 -0400
Received: from muru.com ([72.249.23.125]:58376 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbeJEV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:29:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F396280B6;
        Fri,  5 Oct 2018 14:34:35 +0000 (UTC)
Date:   Fri, 5 Oct 2018 07:30:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] i2c: omap: use core to detect 'no zero length'
 quirk
Message-ID: <20181005143002.GI5662@atomide.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-5-wsa+renesas@sang-engineering.com>
 <20181005122409.GH5433@kunai>
 <0a7bf9ae-8c20-ce11-0c01-33a3f0eeb93a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7bf9ae-8c20-ce11-0c01-33a3f0eeb93a@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [181005 14:16]:
> 
> 
> On 10/05/2018 07:24 AM, Wolfram Sang wrote:
> > On Mon, Jul 23, 2018 at 10:26:08PM +0200, Wolfram Sang wrote:
> > > And don't reimplement in the driver.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Ping.
> > 
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
