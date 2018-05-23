Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbeEWPOr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:14:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:34055 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933540AbeEWPOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:14:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="43314711"
Date: Wed, 23 May 2018 09:16:38 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>, linux-nvme@lists.infradead.org,
        axboe@fb.com, keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: host: core: fix precedence of ternary operator
Message-ID: <20180523151638.GB11037@localhost.localdomain>
References: <20180523145611.10297-1-brnkv.i1@gmail.com>
 <2cdc9032-901d-fbec-69e5-63087923e4b1@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdc9032-901d-fbec-69e5-63087923e4b1@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
