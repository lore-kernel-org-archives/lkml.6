Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbeEIHyL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:54:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58663 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933821AbeEIHyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:54:09 -0400
Date: Wed, 9 May 2018 09:54:07 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] mempool: Add mempool_init()/mempool_exit()
Message-ID: <20180509075407.oz7l6gkolepciudx@linux-x5ow.site>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509013358.16399-2-kent.overstreet@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:33:49PM -0400, Kent Overstreet wrote:
> +/**
> + * mempool_destroy - exit a mempool initialized with mempool_init()

^ mempool_exit()

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
