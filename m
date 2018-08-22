Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65003C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34620C07
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="GBIGn0PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F34620C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeHVN5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:57:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50206 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHVN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:57:01 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6D66625AD64;
        Wed, 22 Aug 2018 20:32:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534933960; bh=kbtcj1uuukfgSK5W3KdRAcz1lHrhnSmkZne816oM1Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBIGn0PGd4UhunXvb4U3S0vJkrbrhLB3ZUS1i5Lahe9ab24HmrjOIawRmyb3ZDRvA
         A4Mz3I+Wbiv7F5rYcMbyABrPsKnR3rfwbhq0qnJEbs6oSGOrhGU5ammHaJ1JkzvuKA
         XhRVGY3aLtWJYn5lLY7lhYcYN7nZ9O0bAsD4QORw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 5405A94040B; Wed, 22 Aug 2018 12:32:38 +0200 (CEST)
Date:   Wed, 22 Aug 2018 12:32:38 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update tree location for the Renesas DRM
 drivers
Message-ID: <20180822103237.oig5ozsa2ib22g43@verge.net.au>
References: <20180819221413.1031-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819221413.1031-1-laurent.pinchart+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 01:14:13AM +0300, Laurent Pinchart wrote:
> The fbdev git tree referenced in the MAINTAINERS file doesn't exist
> anymore. Update the location to point to the new git tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

