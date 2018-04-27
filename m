Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeD0FSh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:18:37 -0400
Received: from verein.lst.de ([213.95.11.211]:45448 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeD0FSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:18:36 -0400
Date: Fri, 27 Apr 2018 07:20:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: change order of qid and cmdid in completion
        trace
Message-ID: <20180427052027.GA9698@lst.de>
References: <20180426202515.20206-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426202515.20206-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
