Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCLS5i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:57:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:60649 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeCLS5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:57:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="207540742"
Date: Mon, 12 Mar 2018 12:59:32 -0600
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180312185932.GH18494@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
 <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianchao,

The patch tests fine on all hardware I had. I'd like to queue this up
for the next 4.16-rc. Could you send a v3 with the cleanup changes Andy
suggested and a changelog aligned with Ming's insights?

Thanks,
Keith
