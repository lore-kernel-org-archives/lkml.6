Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2BFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5044120868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty9wFYA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5044120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeKYB2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKYB2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:28:42 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B4620868;
        Sat, 24 Nov 2018 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543070407;
        bh=x2ALFsHs3pdByosXACkyxSMZZmRBTlZpUpHpP7uv0RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ty9wFYA40niD1Dg36gk73bxt7IQQJC6mGh/c71xVtTS9Au7l9Qu/tyhoidbtc8mgJ
         3D7loIijjp128oizlXu1tIu03Tgmbqthy77t0yVFLTd7UZ3TRs0FQzNSscm+SDB0oe
         HBueffSXGDwrY3P4u99rAlEPspKj0tmJRxMOYFXU=
Date:   Sat, 24 Nov 2018 20:09:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ep93xx_dma: fix misspell
Message-ID: <20181124143958.GN3175@vkoul-mobl.Dlink>
References: <20181119151531.17989-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119151531.17989-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-18, 10:15, Yangtao Li wrote:
> couln't -> couldn't

Applied, thanks

-- 
~Vinod
