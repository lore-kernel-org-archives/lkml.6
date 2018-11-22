Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFACCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEA220672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEA220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436771AbeKVXir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:38:47 -0500
Received: from 8bytes.org ([81.169.241.247]:48922 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391180AbeKVXir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:38:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 96E662F5; Thu, 22 Nov 2018 13:59:31 +0100 (CET)
Date:   Thu, 22 Nov 2018 13:59:31 +0100
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
Subject: Re: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
Message-ID: <20181122125931.GC1586@8bytes.org>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 17, 2018 at 10:35:27AM +0800, Yong Wu wrote:
> Yong Wu (14):
>   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
>   iommu/mediatek: Use a struct as the platform data
>   memory: mtk-smi: Use a general config_port interface
>   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
>     helpers
>   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
>   iommu/mediatek: Add mt8183 IOMMU support
>   iommu/mediatek: Add mmu1 support
>   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
>   memory: mtk-smi: Use a struct for the platform data for smi-common
>   memory: mtk-smi: Add bus_sel for mt8183
>   iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
>   iommu/mediatek: Add shutdown callback
>   memory: mtk-smi: Get rid of need_larbid
>   iommu/mediatek: Switch to SPDX license identifier

This should probably go through the IOMMU tree. For that I'd like to
have Acks (reviews are even better) for the io-pgtable parts from Robin
and for the memory parts from Matthias first.


Regards,

	Joerg

