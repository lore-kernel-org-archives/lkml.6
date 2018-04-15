Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeDOPDd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 11:03:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeDOPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 11:03:31 -0400
Date: Sun, 15 Apr 2018 08:03:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: mingo@kernel.org, linux@dominikbrodowski.net, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hch@lst.de,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
        peterz@infradead.org
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] swiotlb: Use dma_direct_supported() for
 swiotlb_ops
Message-ID: <20180415150315.GA30367@infradead.org>
References: <20180409091517.6619-2-hch@lst.de>
 <tip-66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-66bdb1478fd1a66d5b8b81e4e28e0ed3df63ed37@git.kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you plan to send this on to Linus?  Would be great to have this in
for rc1..
