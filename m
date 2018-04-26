Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755697AbeDZUVo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:21:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754529AbeDZUVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:21:41 -0400
Date: Thu, 26 Apr 2018 14:21:36 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: change order of qid and cmdid in completion trace
Message-ID: <20180426202136.owimd773x5p5upxn@linux-x5ow.site>
References: <20180426194926.18767-1-jthumshirn@suse.de>
 <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:01:59PM -0600, Jens Axboe wrote:
> On 4/26/18 1:49 PM, Johannes Thumshirn wrote:
> > Keith reported that command submission and command completion
> > tracepoints have the order of the cmdid and qid fileds swapped.
> > 
> > While it isn't easily possible to change the command submission
> > tracepoint, as there is a regression test parsing it in blktests we
> > can swap the command completion tracepoint to have the fileds aligned.
> 
> It also makes more sense to have qid before cmdid.
> 
> Also, fileds -> fields, in two spots.

Args. Thanks

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
