Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41142ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC429208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC429208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeGQHTR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:19:17 -0400
Received: from muru.com ([72.249.23.125]:51746 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeGQHTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:19:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4F24F80C5;
        Tue, 17 Jul 2018 06:51:24 +0000 (UTC)
Date:   Mon, 16 Jul 2018 23:48:11 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: [PATCH] dts/droid4: fix dts w.r.t. pwm
Message-ID: <20180717064811.GA99251@atomide.com>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071048.GA23110@amd>
 <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [180716 10:14]:
> Hi,
> 
> On Mon, Jul 16, 2018 at 09:10:48AM +0200, Pavel Machek wrote:
> > pwm node should not be under gpio6 node in the device tree.
> >    
> > This fixes detection of the pwm on Droid 4.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applying into omap-for-v4.18/fixes thanks.

Tony
