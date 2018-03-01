Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965388AbeCAAwY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:52:24 -0500
Received: from verein.lst.de ([213.95.11.211]:56477 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965286AbeCAAwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:52:21 -0500
Date: Thu, 1 Mar 2018 01:52:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Laurence Oberman <loberman@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus()
        to pci_alloc_irq_vectors
Message-ID: <20180301005220.GB29500@lst.de>
References: <20180206121742.29336-1-ming.lei@redhat.com> <20180206121742.29336-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206121742.29336-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

and we should pick this up for 4.16 independent of the rest, which
I might need a little more review time for.

Reviewed-by: Christoph Hellwig <hch@lst.de>
