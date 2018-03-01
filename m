Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967713AbeCALEI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:04:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54597 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966128AbeCALEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:04:04 -0500
X-Google-Smtp-Source: AG47ELt+6lWpwnDiOSS+GukeHcERX0YoTc49bVsKKRMOWF2dpkL18x8QEaicTHZ6zWSJn5j+pqfUBw==
Subject: Re: [PATCH v2 09/10] nvme-pci: Add a quirk for a pseudo CMB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-10-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <85896210-f963-7d0b-e60e-0cd903677c09@grimberg.me>
Date: Thu, 1 Mar 2018 13:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228234006.21093-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
