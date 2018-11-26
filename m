Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8102C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E8C20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcZWfnGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E8C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeK0B4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbeK0B4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:56:06 -0500
Received: from localhost (unknown [178.228.8.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23F720862;
        Mon, 26 Nov 2018 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543244503;
        bh=RGi+0FSQngd5D97NR+avqDs5xfLbzfYEQISuLTKyOrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcZWfnGVfJZVCdvB9+/JV0Hc0qauUJEWDf3LjeZWd07MIZlyKh/T1r+QrSmTM2SIL
         zIm5T4GZ8jwmL5NJBUw7QqpmQv8PbOUuM9ZzinBHAsC5Hf8GRAa7k7j/yJJ2v6J75S
         ZIUPilwOCF90ls0P4E3VWDyxquxpWOhVI4ah7fgw=
Date:   Mon, 26 Nov 2018 16:01:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 32/62] i2c: omap: Enable for ARCH_K3
Message-ID: <20181126150140.GC4637@kroah.com>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105053.367583470@linuxfoundation.org>
 <3c9dbe29-1fa0-9e2d-7fe2-6049dd38716f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9dbe29-1fa0-9e2d-7fe2-6049dd38716f@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:54:45PM +0530, Vignesh R wrote:
> Hi Greg,
> 
> On 26/11/18 4:21 PM, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> 
> This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
> Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
> merged to mainline in v4.19. Since I don't see c77245722fb4 in
> stable tree, could you please drop this patch from _all prior versions_
> i.e 4.14, 4.9, 4.4 and 3.18. Thanks!

Now dropped, thanks for letting us know.

greg k-h
