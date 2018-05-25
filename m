Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935722AbeEYNr4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:47:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934100AbeEYNrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:47:55 -0400
Date: Fri, 25 May 2018 09:47:54 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 1/3] nvme: provide a way to disable nvme mpath per
 subsystem
Message-ID: <20180525134753.GA9591@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525125322.15398-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525125322.15398-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2018 at  8:53am -0400,
Johannes Thumshirn <jthumshirn@suse.de> wrote:

> Provide a way to disable NVMe native multipathing on a per-subsystem
> basis to enable a user to use dm-mpath and nvme native multipathing on
> the same host for different nvme devices.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>
