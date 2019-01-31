Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD082086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfAaMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:07:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55870 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfAaMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:07:15 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gpB7W-0003tR-GB; Thu, 31 Jan 2019 13:07:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, airlied@linux.ie, linux@armlinux.org.uk,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCHv2 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
Date:   Thu, 31 Jan 2019 13:07:05 +0100
Message-ID: <8111278.aDhVmSDgJm@phil>
In-Reply-To: <20190131031040.GA2320@jordon-HP-15-Notebook-PC>
References: <20190131031040.GA2320@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Januar 2019, 04:10:40 CET schrieb Souptick Joarder:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

hmm, I'm missing a changelog here between v1 and v2.
Nevertheless I managed to test v1 on Rockchip hardware
and display is still working, including talking to Lima via prime.

So if there aren't any big changes for v2, on Rockchip
Tested-by: Heiko Stuebner <heiko@sntech.de>

Heiko


