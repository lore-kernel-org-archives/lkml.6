Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEVKEd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:04:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:04:30 -0400
Date: Tue, 22 May 2018 03:04:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
        darrick.wong@oracle.com, rgoldwyn@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/5] fs: Convert kiocb rw_hint from enum to u16
Message-ID: <20180522100427.GA30026@infradead.org>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
 <20180521160147.2372-3-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521160147.2372-3-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 09:01:44AM -0700, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> In order to avoid kiocb bloat for per command iopriority support, rw_hint
> is converted from enum to a u16. Added a guard around ki_hint assigment.
> 
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
