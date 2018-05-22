Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEVKFT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:05:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeEVKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:05:17 -0400
Date: Tue, 22 May 2018 03:05:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
        darrick.wong@oracle.com, rgoldwyn@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 3/5] fs: Add aio iopriority support
Message-ID: <20180522100515.GB30026@infradead.org>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
 <20180521160147.2372-4-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521160147.2372-4-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
