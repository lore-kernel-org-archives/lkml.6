Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeEaCnJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:43:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932621AbeEaCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:43:06 -0400
Date: Thu, 31 May 2018 10:42:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180531024247.GA15700@ming.t460p>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de>
 <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com>
 <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:22:40AM +0200, Johannes Thumshirn wrote:
> On Mon, May 28, 2018 at 11:02:36PM -0400, Mike Snitzer wrote:
> > No, what both Red Hat and SUSE are saying is: cool let's have a go at
> > "Plan A" but, in parallel, what harm is there in allowing "Plan B" (dm
> > multipath) to be conditionally enabled to coexist with native NVMe
> > multipath?
> 
> For a "Plan B" we can still use the global knob that's already in
> place (even if this reminds me so much about scsi-mq which at least we
> haven't turned on in fear of performance regressions).

BTW, for scsi-mq, we have made a little progress by commit 2f31115e940c
(scsi: core: introduce force_blk_mq), and virtio-scsi is working at
always scsi-mq mode now. Then driver can decide if .force_blk_mq needs
to be set.

Hope progress can be made in this nvme mpath issue too.

Thanks,
Ming
