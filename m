Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbeBMNlc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:41:32 -0500
Received: from 8bytes.org ([81.169.241.247]:37004 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964824AbeBMNlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:41:31 -0500
Date: Tue, 13 Feb 2018 14:41:28 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        arnd@arndb.de, honghui.zhang@mediatek.com,
        Bibby Hsieh <bibby.hsieh@mediatek.com>, youlin.pei@mediatek.com
Subject: Re: [PATCH v4] iommu/mediatek: Move attach_device after iommu-group
 is ready for M4Uv1
Message-ID: <20180213134128.nki33e2yljv7scis@8bytes.org>
References: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 03:11:28PM +0800, Yong Wu wrote:
> ---
>  drivers/iommu/mtk_iommu_v1.c | 54 +++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)

Applied, thanks.
