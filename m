Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969200AbeEXNeU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:34:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:5859 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965818AbeEXNeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:34:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="49760095"
Date: Thu, 24 May 2018 07:36:34 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: set nvmeq->cq_vector after alloc cq/sq
Message-ID: <20180524133634.GG11037@localhost.localdomain>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>
