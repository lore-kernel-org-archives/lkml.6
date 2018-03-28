Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeC1OFF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:05:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36715 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752945AbeC1OFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:05:03 -0400
Message-ID: <1522245901.24923.6.camel@suse.de>
Subject: Re: [PATCH] nvme: use upper_32_bits() instead of bit shift
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Matias =?ISO-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Wed, 28 Mar 2018 16:05:01 +0200
In-Reply-To: <20180328135817.2419127-1-arnd@arndb.de>
References: <20180328135817.2419127-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
