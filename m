Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755094AbeE2HiB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:38:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754791AbeE2Hh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:37:57 -0400
Date: Tue, 29 May 2018 09:37:55 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jason Yan <yanaijie@huawei.com>
Cc: martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com, hare@suse.com,
        dan.j.williams@intel.com, hch@lst.de, huangdaode@hisilicon.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com, tj@kernel.org,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
Subject: Re: [PATCH 3/8] scsi: libsas: always unregister the old device if
 going to discover new
Message-ID: <20180529073755.dml26snrgmohxzk5@linux-x5ow.site>
References: <20180529022309.21071-1-yanaijie@huawei.com>
 <20180529022309.21071-4-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529022309.21071-4-yanaijie@huawei.com>
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
