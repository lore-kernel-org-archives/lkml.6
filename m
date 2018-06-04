Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFDMsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55363 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbeFDMsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:48:33 -0400
Date: Mon, 4 Jun 2018 14:48:30 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>, James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180604124829.pnpzt6vgijmrtfty@linux-x5ow.site>
References: <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <20180531163311.GA30954@lst.de>
 <20180531181757.GB11848@redhat.com>
 <yq17enjut3q.fsf@oracle.com>
 <20180601042441.GB14244@redhat.com>
 <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>
 <20180603160626.GA4361@redhat.com>
 <29bfbc6c-861d-0348-2f8b-e803acad43ea@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29bfbc6c-861d-0348-2f8b-e803acad43ea@grimberg.me>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:46:47PM +0300, Sagi Grimberg wrote:
> I agree with Christoph that changing personality on the fly is going to
> be painful. This opt-in will need to be one-host at connect time. For
> that, we will probably need to also expose an argument in nvme-cli too.
> Changing the mpath personality will need to involve disconnecting the
> controller and connecting again with the argument toggled. I think this
> is the only sane way to do this.

If we still want to make it dynamically, yes. I've raised this concern
while working on the patch as well.

> Another path we can make progress in is user visibility. We have
> topology in place and you mentioned primary path (which we could
> probably add). What else do you need for multipath-tools to support
> nvme?

I think the first priority is getting nvme notion into multipath-tools
like I said elsewhere and then see. Martin Wilck was already working
on patches for this.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
