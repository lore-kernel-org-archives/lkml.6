Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78DD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iB4UdqDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78DD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeGROcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:32:50 -0400
Received: from 8bytes.org ([81.169.241.247]:32834 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbeGROcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:32:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 241521D3; Wed, 18 Jul 2018 15:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531922087; bh=9fhFEJ8NsmWNKO60PVus3+h84X/pDBsCL0bvr2EH93c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB4UdqDuUPALFoFOLPO+QSlEIW39Fb+rA9DVY4vaOlMwdRVsh7wAoOwHoO2oU/oDX
         nDWu4w0j1yLVP8u4ZmrVCayKWDLwkj5re0SlfbGEIJI33j7l06pqE7bQ1Fs7EVA5zQ
         Z+GWg6RH2YqgSlzDl2FjSatON9RU59JqA/AELNtpeVe9wupfjnPMi8P5rFSpVqgAsd
         U1wp9rXdjQ6ufL9akcP4Oa6cZBU5mT9gItE4SmyBZva7QLyM8BsDKnNXm4pdG5GWZ9
         7Oj/FnXrOCZGwuvU+T0o0S/We0jjFoD6mtOpLB+MPdxoh91BVDQ6Q3U+PXgEPOvmTN
         agLioIPAzXkmA==
Date:   Wed, 18 Jul 2018 15:54:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, arnd@arndb.de
Subject: Re: [PATCH v4] dt-bindings: mediatek: Add binding for mt2712 IOMMU
 and SMI
Message-ID: <20180718135446.GB18541@8bytes.org>
References: <1527165331-22261-1-git-send-email-yong.wu@mediatek.com>
 <1529562433.22229.2.camel@mhfsdcap03>
 <d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:28:14PM +0200, Matthias Brugger wrote:
> >>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
> >>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
> >>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
> >>  include/dt-bindings/memory/mt2712-larb-port.h      | 95 ++++++++++++++++++++++
> >>  4 files changed, 106 insertions(+), 6 deletions(-)
> >>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
> >>
> 
> Joerg, will you take this through your tree, or would you mind to provide a
> Acked-By?

Sure,

	Acked-by: Joerg Roedel <jroedel@suse.de>
