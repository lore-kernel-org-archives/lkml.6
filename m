Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeDMQns (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:43:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeDMQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:43:46 -0400
Date: Fri, 13 Apr 2018 09:43:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        dalias@libc.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] base: dma-mapping: Postpone cpu addr translation on
 mmap()
Message-ID: <20180413164333.GA2205@infradead.org>
References: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180409175251.GA5426@infradead.org>
 <20180410075752.GB20945@w540>
 <20180413163009.GE6666@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413163009.GE6666@w540>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please send a v2.
