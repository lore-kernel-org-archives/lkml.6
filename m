Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeCHVHW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:07:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeCHVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:07:21 -0500
Date: Thu, 8 Mar 2018 16:06:40 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] x86: remove X86_PPRO_FENCE
Message-ID: <20180308210640.GP12029@char.us.oracle.com>
References: <20180305174655.9878-1-hch@lst.de>
 <20180305174655.9878-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305174655.9878-2-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:46:43AM -0800, Christoph Hellwig wrote:
> There were only a few Pentium Pro multiprocessors systems where this
> errata applied. They are more than 20 years old now, and we've slowly
> dropped places where put the workarounds in and discouraged anyone
> from enabling the workaround.
> 
> Get rid of it for good.
> 

RIP.
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
