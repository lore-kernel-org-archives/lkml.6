Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DA1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF67208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF67208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbeISNCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:02:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40530 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeISNCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:02:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A337A20795; Wed, 19 Sep 2018 09:26:16 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7892820703;
        Wed, 19 Sep 2018 09:26:16 +0200 (CEST)
Date:   Wed, 19 Sep 2018 09:26:16 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: berlin-usb: switch to SPDX identifier
Message-ID: <20180919072616.GA1158@kwain>
References: <20180713154704.16769-1-antoine.tenart@bootlin.com>
 <20180919071331.GA599@kwain>
 <71e45b52-a622-5ee3-3f19-fb5a4f2e8d81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71e45b52-a622-5ee3-3f19-fb5a4f2e8d81@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 12:50:51PM +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 19 September 2018 12:43 PM, Antoine Tenart wrote:
> > 
> > Any update about these two patches?
> 
> Looks like patches for this from Jisheng Zhang has already made into the 4.19
> kernel.

OK, I see. Thanks!

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
