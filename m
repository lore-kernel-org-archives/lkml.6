Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeEWPGV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:06:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:10025 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933151AbeEWPGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:06:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="226635319"
Date: Wed, 23 May 2018 09:08:31 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Message-ID: <20180523150831.GA11037@localhost.localdomain>
References: <20180517115250.10027-1-jthumshirn@suse.de>
 <20180523145420.5ly2r4xjq2u25vv2@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523145420.5ly2r4xjq2u25vv2@linux-x5ow.site>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the ping. I started a new branch, nvme-4.18-2, based off of
Jens' for-next with this being the first new commit.

I'm certain we're still missing a lot of reviewed commits. I'll try to
go through the mail history and apply by the end of the week, but any
friendly reminders would not be unappreciated. :)
