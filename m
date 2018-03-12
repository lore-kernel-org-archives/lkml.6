Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeCLVSm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:18:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:56226 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932242AbeCLVSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:18:40 -0400
To: Jonathan Corbet <corbet@lwn.net>
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
        Alex Williamson <alex.williamson@redhat.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-6-logang@deltatee.com> <20180312134114.1e4b12f8@lwn.net>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0204d22a-72fa-d7fb-ae8e-8d20d80cb4a6@deltatee.com>
Date: Mon, 12 Mar 2018 15:18:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312134114.1e4b12f8@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 05/11] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/2018 1:41 PM, Jonathan Corbet wrote:
> This all seems good, but...could we consider moving this documentation to
> driver-api/PCI as it's converted to RST?  That would keep it together with
> similar materials and bring a bit more coherence to Documentation/ as a
> whole.

Yup, I'll change this for the next revision.

Thanks,

Logan
