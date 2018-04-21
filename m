Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeDUHGB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:06:01 -0400
Received: from verein.lst.de ([213.95.11.211]:45112 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeDUHGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:06:00 -0400
Date: Sat, 21 Apr 2018 09:07:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.h.duyck@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Subject: Re: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs
        that function only to enable VFs
Message-ID: <20180421070702.GE24431@lst.de>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com> <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
