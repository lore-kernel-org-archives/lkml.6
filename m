Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeEWNeq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932898AbeEWNeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:34:44 -0400
Date: Wed, 23 May 2018 19:04:41 +0530
From: Vinod <vkoul@kernel.org>
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dma: imx-sdma: add virt-dma support
Message-ID: <20180523133441.GK20991@vkoul-mobl>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
 <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
 <1527099973.3990.37.camel@nxp.com>
 <20180523105612.u4wbezh7fzkv4wfh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523105612.u4wbezh7fzkv4wfh@pengutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 12:56, s.hauer@pengutronix.de wrote:

> Well, it's somewhat related to virtual dma support, but that's not my
> point. My point is that this patch is quite big and thus hard to review.
> If we find ways to make it smaller and to split it up in multiple
> patches then we should do so, because it makes it easier to review and
> in case you break something here we raise the chance that a "git bisect"
> lands on a smaller patch which is easier to understand.
> 
> Please try and make that a separate change. I haven't really looked into
> it and it may not be possible due to reasons I haven't seen, but please
> at least give it a try.

That is something would help me as well. I have reviewed the patch and am not
sure I fully understand the changes, so breaking up stuff would definitely help
in the review..

-- 
~Vinod
