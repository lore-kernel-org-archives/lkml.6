Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeBLUZc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:25:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:58328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeBLUZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:25:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="26757826"
Date: Mon, 12 Feb 2018 13:25:19 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme: fix the deadlock in nvme_update_formats
Message-ID: <20180212202519.GA20962@localhost.localdomain>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
 <16c23a0c-666c-802e-2b4e-c6a6da6f016b@grimberg.me>
 <20180212192009.GE16255@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212192009.GE16255@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

This one is fixing a deadlock in namespace detach. It is still not a
widely supported operation, but becoming more common. While the other two
patches in this series look good for 4.17, I would really recommend this
one for 4.16-rc, and add a Cc to linux-stable for 4.15 too. Sound okay?

Thanks,
Keith
