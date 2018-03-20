Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCTS50 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:57:26 -0400
Received: from 8bytes.org ([81.169.241.247]:34318 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTS5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:57:23 -0400
Date: Tue, 20 Mar 2018 13:57:17 -0500
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        arnd@arndb.de, honghui.zhang@mediatek.com, youlin.pei@mediatek.com
Subject: Re: [PATCH] iommu/mediatek: Fix protect memory setting
Message-ID: <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
References: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 09:52:54AM +0800, Yong Wu wrote:
> To avoid adding this complex macro or a new function, I put
> it in the code and backup its value in the suspend registers.

Missing Signed-off-by.

> ---
>  drivers/iommu/mtk_iommu.c | 15 ++++++++++-----
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)


Joerg
