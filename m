Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755647AbeEHTPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:15:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60454 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755472AbeEHTPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:15:10 -0400
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180507232346.GI161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180508105759.7dbaa8fe@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7d06df03-18ee-97c7-595e-0b25c43a6f3d@deltatee.com>
Date: Tue, 8 May 2018 13:14:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508105759.7dbaa8fe@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, alex.williamson@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/18 10:57 AM, Alex Williamson wrote:
> AIUI from previously questioning this, the change is hidden behind a
> build-time config option and only custom kernels or distros optimized
> for this sort of support would enable that build option.  I'm more than
> a little dubious though that we're not going to have a wave of distros
> enabling this only to get user complaints that they can no longer make
> effective use of their devices for assignment due to the resulting span
> of the IOMMU groups, nor is there any sort of compromise, configure
> the kernel for p2p or device assignment, not both.  Is this really such
> a unique feature that distro users aren't going to be asking for both
> features?  Thanks,

I think it is. But it sounds like the majority want this to be a command
line option. So we will look at doing that for v5.

Logan
