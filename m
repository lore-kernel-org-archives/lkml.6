Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeBVWHu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:07:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:31776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbeBVWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:07:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,380,1515484800";
   d="scan'208";a="32093970"
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>
Subject: Re: [RFC PATCH V2] virtio_pci: Add SR-IOV support
Thread-Topic: [RFC PATCH V2] virtio_pci: Add SR-IOV support
Thread-Index: AQHTrAqohlH7raXrq0ab9Bfoe7ziTKOxgSiA
Date: Thu, 22 Feb 2018 22:07:45 +0000
Message-ID: <A2CEFBAB-8FD1-4C55-B87A-770C9F080EC2@intel.com>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
 <20180222182622.GA13815@infradead.org>
In-Reply-To: <20180222182622.GA13815@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.233.81.27]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E24BEFD855DD514BB82292943B9C091D@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 22, 2018, at 10:26 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> Can we move this into common code as a a generic_sriov_configure
> helper?  Nothing is really virtio specific, and it seems like
> some other drivers could also use it, e.g. ena or nvme.

That seems like a good idea to me, especially if PCI developers concur.

-- 
Mark Rustad, Networking Division, Intel Corporation
