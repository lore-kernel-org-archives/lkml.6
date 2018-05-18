Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeERUWM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:22:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeERUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:22:10 -0400
Date: Fri, 18 May 2018 16:22:04 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] swiotlb: remove a pointless comment
Message-ID: <20180518202203.GI23713@char.us.oracle.com>
References: <20180515180523.3038-1-hch@lst.de>
 <20180515180523.3038-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515180523.3038-2-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:05:18PM +0200, Christoph Hellwig wrote:
> This comments describes an aspect of the map_sg interface that isn't
> even exploited by swiotlb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied.
> ---
>  lib/swiotlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 16ace0e25d52..721f93677eee 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -927,12 +927,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * appropriate dma address and length.  They are obtained via
>   * sg_dma_{address,length}(SG).
>   *
> - * NOTE: An implementation may be able to use a smaller number of
> - *       DMA address/length pairs than there are SG table elements.
> - *       (for example via virtual mapping capabilities)
> - *       The routine returns the number of addr/length pairs actually
> - *       used, at most nents.
> - *
>   * Device ownership issues as mentioned above for swiotlb_map_page are the
>   * same here.
>   */
> -- 
> 2.17.0
> 
