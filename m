Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeC1O7H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:59:07 -0400
Received: from verein.lst.de ([213.95.11.211]:46021 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbeC1O7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:59:06 -0400
Date: Wed, 28 Mar 2018 16:59:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <maxg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: target: fix buffer overflow
Message-ID: <20180328145904.GA7174@lst.de>
References: <20180328135522.2345359-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328135522.2345359-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
