Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDWMy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:54:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755128AbeDWMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:54:23 -0400
Date: Mon, 23 Apr 2018 05:53:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        hch@infradead.org, ysato@users.sourceforge.jp, dalias@libc.org,
        iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] base: dma-mapping: Postpone cpu addr translation on
 mmap()
Message-ID: <20180423125355.GA13536@infradead.org>
References: <1523640337-26064-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523640337-26064-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for 4.17.
