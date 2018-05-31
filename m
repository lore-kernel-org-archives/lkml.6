Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbeEaQmi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:42:38 -0400
Received: from verein.lst.de ([213.95.11.211]:39067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755556AbeEaQmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:42:36 -0400
Date: Thu, 31 May 2018 18:49:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] nvmet: fix error return code in
        nvmet_file_ns_enable()
Message-ID: <20180531164904.GC31353@lst.de>
References: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-4.18.
