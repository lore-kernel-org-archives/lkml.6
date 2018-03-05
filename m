Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeCEURA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:17:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35496 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeCEUQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:16:58 -0500
To: Jason Gunthorpe <jgg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
 <20180305201053.GK11337@mellanox.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <608840df-85a6-6d3b-70b4-43b037db58c9@deltatee.com>
Date: Mon, 5 Mar 2018 13:16:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305201053.GK11337@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, bhelgaas@google.com, jglisse@redhat.com, alex.williamson@redhat.com, keith.busch@intel.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org, benh@kernel.crashing.org, linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me, jgg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/18 01:10 PM, Jason Gunthorpe wrote:
> So when reading the above mlx code, we see the first wmb() being used
> to ensure that CPU stores to cachable memory are visible to the DMA
> triggered by the doorbell ring.

Oh, yes, that makes sense. Disregard my previous email as I was wrong.

Logan
