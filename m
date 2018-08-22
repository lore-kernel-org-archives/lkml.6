Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEAB20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dYgu3rgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEAB20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeHVM7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:59:00 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49485 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbeHVM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:58:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 11BEC25AD64;
        Wed, 22 Aug 2018 19:34:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534930492; bh=8iJ/c4NIz9OApD2jdlCGtWl9ZbCKMNLCiObGs//wWbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYgu3rgSPT7LAXzXD4Izc25CxH4eOcjhYj0w116sHE8j+6tFLVXlt5oBQjz4MRvDv
         tqnSxkqAhpt0K50BP2ewHc/XSWHU4ojPFZBV+pXfLFdrf4+6M3myVFb2CstuXGpLgr
         oFoq77x0bBzLmQsH40izx3DKdUGr1y12QftksJcg=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 1A95E94040B; Wed, 22 Aug 2018 11:34:50 +0200 (CEST)
Date:   Wed, 22 Aug 2018 11:34:50 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] i2c: use SPDX identifier for Renesas drivers
Message-ID: <20180822093449.gfvdzfqfv7txvajy@verge.net.au>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821220233.9202-4-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:02:16AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

