Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeE2IDy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:03:54 -0400
Received: from verein.lst.de ([213.95.11.211]:53819 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754919AbeE2IDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:03:43 -0400
Date: Tue, 29 May 2018 10:09:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Martin George <marting@netapp.com>, Christoph Hellwig <hch@lst.de>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180529080952.GA1369@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com> <yq1muwj45sg.fsf@oracle.com> <20180529030236.GA28895@redhat.com> <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:22:40AM +0200, Johannes Thumshirn wrote:
> For a "Plan B" we can still use the global knob that's already in
> place (even if this reminds me so much about scsi-mq which at least we
> haven't turned on in fear of performance regressions).
> 
> Let's drop the discussion here, I don't think it leads to something
> else than flamewars.

If our plan A doesn't work we can go back to these patches.  For now
I'd rather have everyone spend their time on making Plan A work then
preparing for contingencies.  Nothing prevents anyone from using these
patches already out there if they really want to, but I'd recommend
people are very careful about doing so as you'll lock yourself into
a long-term maintainance burden.
