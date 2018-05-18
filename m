Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbeERIXm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:23:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39961 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753410AbeERIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:23:39 -0400
Date: Fri, 18 May 2018 10:23:38 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] block: Convert bio_set to mempool_init()
Message-ID: <20180518082338.kh2gqck2zvqf7fjs@linux-x5ow.site>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180518074918.13816-4-kent.overstreet@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:49:01AM -0400, Kent Overstreet wrote:
> Minor performance improvement by getting rid of pointer indirections
> from allocation/freeing fastpaths.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Although I'd prefer numbers in the changelog when claiming a
performance improvement.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
