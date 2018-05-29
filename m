Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbeE2HWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:22:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37667 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeE2HWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:22:42 -0400
Date: Tue, 29 May 2018 09:22:40 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Martin George <marting@netapp.com>, Christoph Hellwig <hch@lst.de>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de>
 <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com>
 <20180529030236.GA28895@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529030236.GA28895@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:02:36PM -0400, Mike Snitzer wrote:
> No, what both Red Hat and SUSE are saying is: cool let's have a go at
> "Plan A" but, in parallel, what harm is there in allowing "Plan B" (dm
> multipath) to be conditionally enabled to coexist with native NVMe
> multipath?

For a "Plan B" we can still use the global knob that's already in
place (even if this reminds me so much about scsi-mq which at least we
haven't turned on in fear of performance regressions).

Let's drop the discussion here, I don't think it leads to something
else than flamewars.

     Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
