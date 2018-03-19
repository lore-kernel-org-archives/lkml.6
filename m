Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933062AbeCSKjt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:39:49 -0400
Received: from verein.lst.de ([213.95.11.211]:58280 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933040AbeCSKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:39:41 -0400
Date: Mon, 19 Mar 2018 11:39:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
        common code
Message-ID: <20180319103939.GA23333@lst.de>
References: <20180305174655.9878-1-hch@lst.de> <20180305174655.9878-12-hch@lst.de> <114e27be-5814-4258-4985-af08763c8a74@amd.com> <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com> <20180313131005.GA6260@lst.de> <69e98163-beca-fb8a-a26b-66dfeef2f689@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e98163-beca-fb8a-a26b-66dfeef2f689@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you test and review the V3 of the series I just sent out?
We reall should get it into linux-next ASAP.
