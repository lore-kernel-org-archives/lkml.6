Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbeEIOVf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:21:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48108 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbeEIOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:21:34 -0400
Date: Wed, 9 May 2018 10:21:18 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, mingo@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Update the comment of swiotlb
Message-ID: <20180509142118.GA27814@char.us.oracle.com>
References: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com>
 <20180509073838.GA20874@lst.de>
 <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
 <20180509113957.GA25787@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509113957.GA25787@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=794
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 01:39:57PM +0200, Christoph Hellwig wrote:
> On Wed, May 09, 2018 at 05:08:30PM +0800, Yisheng Xie wrote:
> > Hi Christoph,
> > 
> > On 2018/5/9 15:38, Christoph Hellwig wrote:
> > > Thanks,
> > > 
> > > applied to the dma-mapping tree.
> > 
> > Thanks
> > 
> > BTW, should lib/swiotlb.c also add to DMA MAPPING HELPERS, or
> > add yourself as a maintainer of SWIOTLB SUBSYSTEM ? It will make
> > get_maintainer.pl get you :)
> 
> Konrad is the maintainer, but due to me touching the file a lot
> lately I keep merging the patches for now.  But anything non-trivial
> absolutely requires an Ack from Konrad.

<nods>

Thank you for pulling this in your tree.
