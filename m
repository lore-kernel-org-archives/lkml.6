Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348E6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2AF2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MonNzLgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2AF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIHVTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 17:19:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIHVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 17:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0lWODs5cRkoEpN569iRvyjWrv1RNNfrywqrUeL6hayU=; b=MonNzLgDGn0jLReWpEmsBZXf8
        ZaWv8Ki4ncuELPuth2jcIponReWwNydMTAdetYgylzO9mgoz5kwloT6XmagiM8tHSU9b3G+n9/z8Z
        dDyiCiJAGxEqVDqdiDhYzjK6X7nOKWUZ70gBQbMOwOTpXcVBaPQn4ymp+cawuNNuDBHMIcUZfT0ht
        FgpQCUQcdTI4Cwnf4qfglj62+ux4f2oDrV+ou0ok22+F3zeUX44MD0rXCcSR6xn4tKB5DpVAumPQP
        EoZWR7h0OD7nqq9Lun9iE+B2HlgW39DQmbI/R9kTHVfmIVTtFvaBEUffCKiH2DA/UemKWJ2q4XIWw
        5YiAeZwtA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fygAg-0004YH-7P; Sat, 08 Sep 2018 16:33:18 +0000
Subject: Re: [PATCH] [trivial] treewide: Fix typos in printk
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20180908134358.4106-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <602f616c-e9ac-8cfc-8075-411f8bbb99a9@infradead.org>
Date:   Sat, 8 Sep 2018 09:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908134358.4106-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 06:43 AM, Masanari Iida wrote:
> This patch fixes some spelling typos found in printk messages.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/dma/ep93xx_dma.c                           | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              | 2 +-
>  drivers/gpu/drm/drm_kms_helper_common.c            | 2 +-
>  drivers/gpu/drm/selftests/test-drm_mm.c            | 2 +-
>  drivers/media/v4l2-core/videobuf-core.c            | 2 +-
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c | 2 +-
>  drivers/net/wireless/marvell/libertas/if_usb.c     | 2 +-
>  drivers/net/wireless/marvell/libertas_tf/if_usb.c  | 4 ++--
>  drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 | 2 +-
>  drivers/soc/imx/gpcv2.c                            | 2 +-
>  fs/gfs2/super.c                                    | 2 +-
>  11 files changed, 14 insertions(+), 14 deletions(-)


-- 
~Randy
