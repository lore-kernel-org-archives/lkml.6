Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeCUOc5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:32:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeCUOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:32:52 -0400
Date: Wed, 21 Mar 2018 10:32:09 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Ingo Molnar <mingo@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Muli Ben-Yehuda <mulix@mulix.org>, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180321143209.GN1110@char.us.oracle.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319152737.GK1110@char.us.oracle.com>
 <20180319152840.GA28041@lst.de>
 <20180320083751.nrpt64dsmpqbhzc6@gmail.com>
 <20180320084412.GA16337@lst.de>
 <20180320090351.2qnwcsauhodrqxdj@gmail.com>
 <CAPbh3rspsGE3i=WzxC4DL=EDTEbhVZVb29j-fyhAXZRwk=Xncg@mail.gmail.com>
 <20180320151600.GA23920@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320151600.GA23920@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:16:00PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 20, 2018 at 11:25:21AM +0000, Konrad Rzeszutek Wilk wrote:
> > Are you testing with swiotlb=force?
> 
> I've done swiotlb=force testing with earlier versions, and otherwise
> relied on a VM with more the 4gb of memory and emulated devices
> without 64-bit capability.

Awesome! I also did my testing so all good. Ingo, if you want to
you can add 'Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>'
on the patches that don't have my tag.

Christoph, thank you for cleaning up this swamp!
