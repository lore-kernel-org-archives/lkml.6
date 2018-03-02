Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbeCBVNF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:13:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:9128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933572AbeCBVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:13:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="208411526"
Date: Fri, 2 Mar 2018 14:12:59 -0700
From: Keith Busch <keith.busch@intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sage@grimberg.me
Subject: Re: [PATCH v2 1/1] nvme: implement log page low/high offset and
 dwords
Message-ID: <20180302211258.GB22933@localhost.localdomain>
References: <20180226125540.9513-1-mb@lightnvm.io>
 <20180226125540.9513-2-mb@lightnvm.io>
 <mqdy3jfc3a1.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqdy3jfc3a1.fsf@linux-x5ow.site>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for 4.17.

A side note for those interested, some bug fixing commits introduced in
the nvme-4.17 branch were applied to 4.16-rc. I've rebased these on top
of linux-block/for-next so we don't have the duplicate commits for the
4.17 merge window. The nvme branch currently may be viewed here:

  http://git.infradead.org/nvme.git/shortlog/refs/heads/for-next
