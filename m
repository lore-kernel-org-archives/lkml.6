Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936194AbeEYOGd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:06:33 -0400
Received: from verein.lst.de ([213.95.11.211]:37151 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935737AbeEYOGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:06:32 -0400
Date: Fri, 25 May 2018 16:12:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>, James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180525141211.GA25971@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525135813.GB9591@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 09:58:13AM -0400, Mike Snitzer wrote:
> We all basically knew this would be your position.  But at this year's
> LSF we pretty quickly reached consensus that we do in fact need this.
> Except for yourself, Sagi and afaik Martin George: all on the cc were in
> attendance and agreed.

And I very mich disagree, and you'd bette come up with a good reason
to overide me as the author and maintainer of this code.

> And since then we've exchanged mails to refine and test Johannes'
> implementation.

Since when was acting behind the scenes a good argument for anything?

> Hopefully this clarifies things, thanks.

It doesn't.

The whole point we have native multipath in nvme is because dm-multipath
is the wrong architecture (and has been, long predating you, nothing
personal).  And I don't want to be stuck additional decades with this
in nvme.  We allowed a global opt-in to ease the three people in the
world with existing setups to keep using that, but I also said I
won't go any step further.  And I stand to that.
