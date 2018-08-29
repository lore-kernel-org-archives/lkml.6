Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F99C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02142064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0x4YyM+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02142064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeH2U2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeH2U2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:28:19 -0400
Received: from localhost (unknown [171.76.77.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A722205C9;
        Wed, 29 Aug 2018 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535560237;
        bh=c86e3jok1axDkgAlNBCJFa+0aYC+nFTHxtqEhK4zipg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0x4YyM+Jw77YGfLn1v8qEl/8Qdw75/nLdrABBG1xLYOhTR+AN0EERSWlLhUjRvnl2
         FYNQrRSMsoAU3zO/BBq+bbHQ/kacG2wL78pbALrakrnyaCNhYPOK5gUwyDDVmRi7ID
         5VS+Ws6NZOBhY26KBCLlzgPx0eNXLc99qQRphFQs=
Date:   Wed, 29 Aug 2018 22:00:28 +0530
From:   Vinod <vkoul@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: use SPDX identifier for Renesas drivers
Message-ID: <20180829163028.GK2388@vkoul-mobl>
References: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
 <20180823133456.4748-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823133456.4748-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-18, 15:34, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied, thanks

-- 
~Vinod
