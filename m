Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74C22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74C22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:52:09 -0500
Received: from 8bytes.org ([81.169.241.247]:53034 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbeLKJwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:52:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8812F3AF; Tue, 11 Dec 2018 10:52:07 +0100 (CET)
Date:   Tue, 11 Dec 2018 10:52:06 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, arnd@arndb.de,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v4 00/18] MT8183 IOMMU SUPPORT
Message-ID: <20181211095206.hj7bnddgv2hqvm4w@8bytes.org>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 04:39:13PM +0800, Yong Wu wrote:
> Arvind Yadav (1):
>   iommu/mediatek: Constify iommu_ops
> 
> Yong Wu (17):
>   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
>   iommu/mediatek: Use a struct as the platform data
>   memory: mtk-smi: Use a general config_port interface
>   memory: mtk-smi: Use a struct for the platform data for smi-common
>   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
>     helpers
>   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
>   iommu/mediatek: Add bclk can be supported optionally
>   iommu/mediatek: Add larb-id remapped support
>   memory: mtk-smi: Add gals support
>   iommu/mediatek: Add mt8183 IOMMU support
>   iommu/mediatek: Add mmu1 support
>   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
>   memory: mtk-smi: Add bus_sel for mt8183
>   iommu/mediatek: Fix VLD_PA_RANGE register backup when suspend
>   iommu/mediatek: Add shutdown callback
>   memory: mtk-smi: Get rid of need_larbid
>   iommu/mediatek: Switch to SPDX license identifier

If Matthias is okay with these patches, I'll queue them for v4.21.


Regards,

	Joerg
