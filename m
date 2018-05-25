Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeEYJY5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:24:57 -0400
Received: from verein.lst.de ([213.95.11.211]:35805 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755045AbeEYJYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:24:55 -0400
Date: Fri, 25 May 2018 11:30:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] arch/x86/kernel/pci-dma: Remove useless parameter
        of arch_dma_alloc_attrs
Message-ID: <20180525093033.GA20094@lst.de>
References: <20180525050000.6076-1-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525050000.6076-1-yehs2007@zoho.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
