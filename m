Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeEGP2B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:28:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:19626 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbeEGP2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:28:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,374,1520924400";
   d="scan'208";a="47379667"
Date: Mon, 7 May 2018 09:29:42 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
Subject: Re: [PATCH] nvme: fix use-after-free in nvme_free_ns_head
Message-ID: <20180507152942.GD20686@localhost.localdomain>
References: <1525420917-9448-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180507122653.GB27843@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507122653.GB27843@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, applied for the next nvme 4.17-rc.
