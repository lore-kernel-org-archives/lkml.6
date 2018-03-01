Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033324AbeCARPt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:15:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:41990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032860AbeCARPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:15:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="24348777"
Date: Thu, 1 Mar 2018 10:17:44 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus()
 to pci_alloc_irq_vectors
Message-ID: <20180301171744.GE14799@localhost.localdomain>
References: <20180206121742.29336-1-ming.lei@redhat.com>
 <20180206121742.29336-6-ming.lei@redhat.com>
 <20180301005220.GB29500@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301005220.GB29500@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 01:52:20AM +0100, Christoph Hellwig wrote:
> Looks fine,
> 
> and we should pick this up for 4.16 independent of the rest, which
> I might need a little more review time for.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, queued up for 4.16.
