Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C133FC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908CB2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550143850;
	bh=WAPsltihHCdxQSkqS987ZvzQsi1u/Rzq/cqKtvhshG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEF9lMzYORDNBNvOo+pR+Eh5RMiDklXSuLg4ZPvuPx3STSnERUVKFcI/hldmZU3Ut
	 j8+WEcCsKH85OFWF/nULsO3vgtrU60TzknQ/pT9GNJhXzdK4P9wW3iVkJBCfIet7JK
	 h6luE4BcE07jG5TCUBZfAQMd78k51BFOHErsV4ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394123AbfBNLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:30:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:55866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729808AbfBNLas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:30:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D35FAC7A;
        Thu, 14 Feb 2019 11:30:47 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:30:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: add entry for memblock
Message-ID: <20190214113047.GB4525@dhcp22.suse.cz>
References: <20190214093630.GC9063@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214093630.GC9063@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-02-19 11:36:31, Mike Rapoport wrote:
> Hi,
> 
> I was surprised to see lots of activity around memblock (beside the churn
> I create there), so I'm going to look after it.
> 
> >From 7b3d02797ef18fb1c515f32125fb9b0055a312de Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Thu, 14 Feb 2019 11:21:26 +0200
> Subject: [PATCH] MAINTAINERS: add entry for memblock
> 
> Add entry for memblock in MAINTAINERS file

It is great that this code gains an official maintainer finaly. Thanks
for stepping in.

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41ce5f4ad838..4e870d8b31af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9792,6 +9792,14 @@ F:	kernel/sched/membarrier.c
>  F:	include/uapi/linux/membarrier.h
>  F:	arch/powerpc/include/asm/membarrier.h
>  
> +MEMBLOCK
> +M:	Mike Rapoport <rppt@linux.ibm.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	include/linux/memblock.h
> +F:	mm/memblock.c
> +F:	Documentation/core-api/boot-time-mm.rst
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
