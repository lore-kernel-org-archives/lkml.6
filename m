Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeCBXIS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:08:18 -0500
Received: from verein.lst.de ([213.95.11.211]:38429 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932885AbeCBXIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:16 -0500
Date: Sat, 3 Mar 2018 00:08:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] genirq/affinity: irq vector spread among online
        CPUs as far as possible
Message-ID: <20180302230815.GD31468@lst.de>
References: <20180206121742.29336-1-ming.lei@redhat.com> <20180206121742.29336-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206121742.29336-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
