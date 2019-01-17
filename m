Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD3820859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547756459;
	bh=0J5x8ir5y1+x/6DKU+VsqdxKasJTs8xBe3yatOlnz7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9hpgJ+jdgUizwqFPA4PWmsuC/iYX88qD0k0lw+U1CfKQ726IMQ7AZ1Z9g9rT2Zoq
	 r/OUiS53azzKsnEgAUi+0jgkBbjDfK+erKCc0EaSllB3+1xrxQgf9te4M7U+MtJ5Eg
	 Ms6KXY9cgu8u656qYqIjBU/nlqqVwYIT/qtgtRec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfAQUU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbfAQUU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:20:57 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1AB20859;
        Thu, 17 Jan 2019 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547756456;
        bh=0J5x8ir5y1+x/6DKU+VsqdxKasJTs8xBe3yatOlnz7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snFpbwVUy7YwXPAAYNRMPZjwlF/5ja23ZRa+vgZqFV2QftOSVf5fUKYKzRL2GewLR
         GNS6ZjpOG2+90RgOXQiI+W9CKRcewyD6qWW688vAxGD6Q/wCgdjkaGO/GOzje3PrM2
         fl+4bnLDVXCf5WN9M3RinoAnopyiGDaBjgX2PycI=
Date:   Thu, 17 Jan 2019 15:20:55 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     haiyangz@microsoft.com
Cc:     kys@microsoft.com, sthemmin@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes,0/3] fixes for hash key setting issues
Message-ID: <20190117202055.GC202535@sasha-vm>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:51:41AM +0000, Haiyang Zhang wrote:
>From: Haiyang Zhang <haiyangz@microsoft.com>
>
>Using ethtool to change Hash key failed on Linux VM runnig on
>Hyper-V. This patch set fix them.
>It targets Hyper-V tree, hyperv-fixes branch managed by
>Sasha Levin <sashal@kernel.org>.

Queued all 3 for hyperv-fixes, thank you.
