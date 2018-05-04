Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDJTI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38031 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEDJTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:19:07 -0400
Date: Fri, 4 May 2018 11:19:06 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: clear NVME_RDMA_Q_LIVE before free the queue
Message-ID: <20180504091906.2yfowtcbmwyaoekl@linux-x5ow.site>
References: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
