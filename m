Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCORyv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:54:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37368 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCORyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:54:50 -0400
Date: Thu, 15 Mar 2018 13:54:22 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] swiotlb: remove swiotlb_set_mem_attributes
Message-ID: <20180315175422.GE19870@char.us.oracle.com>
References: <20180314175213.20256-1-hch@lst.de>
 <20180314175213.20256-12-hch@lst.de>
 <20180315175159.GR13391@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315175159.GR13391@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:51:59PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 14, 2018 at 06:52:10PM +0100, Christoph Hellwig wrote:
> > Now that set_memory_decrypted is always available we can just call it
> > directly.
> > 
> 
> Won't this break ARM build?

<brainfart> And of course right after asking that question I went back to
the previous patch as I had that in my mind it was arch/x86/include, not the global
one.

So pls ignore my query and instead:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
