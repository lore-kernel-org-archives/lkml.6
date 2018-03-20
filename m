Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeCTPQC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:16:02 -0400
Received: from verein.lst.de ([213.95.11.211]:37679 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751694AbeCTPQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:16:01 -0400
Date: Tue, 20 Mar 2018 16:16:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180320151600.GA23920@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319152737.GK1110@char.us.oracle.com> <20180319152840.GA28041@lst.de> <20180320083751.nrpt64dsmpqbhzc6@gmail.com> <20180320084412.GA16337@lst.de> <20180320090351.2qnwcsauhodrqxdj@gmail.com> <CAPbh3rspsGE3i=WzxC4DL=EDTEbhVZVb29j-fyhAXZRwk=Xncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPbh3rspsGE3i=WzxC4DL=EDTEbhVZVb29j-fyhAXZRwk=Xncg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 11:25:21AM +0000, Konrad Rzeszutek Wilk wrote:
> Are you testing with swiotlb=force?

I've done swiotlb=force testing with earlier versions, and otherwise
relied on a VM with more the 4gb of memory and emulated devices
without 64-bit capability.
