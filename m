Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3ED20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3ED20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395204AbeKWCwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:52:11 -0500
Received: from 8bytes.org ([81.169.241.247]:49020 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbeKWCwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:52:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 326E3435; Thu, 22 Nov 2018 17:12:10 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:12:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: remove DEBUG_SEQ_FOPS_RO()
Message-ID: <20181122161208.gp6vrnziuayschai@8bytes.org>
References: <20181122135443.25035-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122135443.25035-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 08:54:43AM -0500, Yangtao Li wrote:
> Because we already have the DEFINE_SHOW_ATTRIBUTE,there is no need
> to define such a macro.So remove DEBUG_SEQ_FOPS_RO.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/omap-iommu-debug.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Applied, thanks.
