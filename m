Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540221710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="nSOliAMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B540221710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeHXMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:52:11 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35915 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeHXMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:52:10 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E60D225BEEB;
        Fri, 24 Aug 2018 19:18:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535102304; bh=uzdD8XPFyLSKtOb1V5D4Dxmohd3Si7VQE+khXUOYal4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSOliAMm/he5gFJDazxfmvUNoz2fSd6xaY0HGY+Ji0Ttblv+faajkEXF/GDDUtW2X
         hXSB+XbMpcTM8u1Cjo+0y/rflMkuTG9DHyar6/V1P94l+OJeMtJPpwbRVU1o19FcLf
         S1ucdCK2zTatFggnP6RnHgRMr5Y7K60V8iQvO1LI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DA86F940443; Fri, 24 Aug 2018 11:18:21 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:18:21 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: use SPDX identifier for Renesas drivers
Message-ID: <20180824091821.z5wieg7mltdbqqf5@verge.net.au>
References: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
 <20180823133456.4748-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823133456.4748-2-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 03:34:54PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

