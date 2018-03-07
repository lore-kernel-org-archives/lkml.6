Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeCGPf4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:35:56 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:44907 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:35:53 -0500
X-Google-Smtp-Source: AG47ELtXuq6LIdAohKxHJTnZnC7fDK4IThFIRUHScWFHQjQ5J0x727D8Cf/CGyGNM+/jneVgKAF5wmVKzbsNGUN8l7k=
MIME-Version: 1.0
In-Reply-To: <20180307124712.14963-3-tvrtko.ursulin@linux.intel.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com> <20180307124712.14963-3-tvrtko.ursulin@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Mar 2018 17:35:51 +0200
Message-ID: <CAHp75VeF-qVGVxzrc8w-Cg58msn4TF1GYFzsOuQ_+0QZV1PfGQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] lib/scatterlist: Skip requesting zeroed allocations
 in sgl_alloc_order
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 2:47 PM, Tvrtko Ursulin <tursulin@ursulin.net> wrote:

> +       sgl = kmalloc_array(nent, sizeof(struct scatterlist), (gfp & ~GFP_DMA));

The parens now become redundant.


-- 
With Best Regards,
Andy Shevchenko
