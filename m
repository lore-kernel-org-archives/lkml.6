Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDDVj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:39:28 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:43489 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeDDVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:39:26 -0400
X-Google-Smtp-Source: AIpwx4+2ZQ0txVNaM+Mj9Z19yah+QbEnSWCiyquqoYhzAkDJOfwN390dYqpz3D8+KlDWjwnF8K45iw==
Date: Thu, 5 Apr 2018 00:39:23 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404213923.GK15783@uranus.lan>
References: <20180404185523.GG15783@uranus.lan>
 <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
 <20180404200426.GH15783@uranus.lan>
 <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
 <20180404212906.GJ15783@uranus.lan>
 <f8669ffd-c176-3dd5-0731-e49494ae7b6f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8669ffd-c176-3dd5-0731-e49494ae7b6f@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 02:36:55PM -0700, Randy Dunlap wrote:
> > 
> > So, maybe just get rid of any warning message at all?
> 
> That would be OK since -EINVAL or something similar is being returned.

Thanks for feedback! Will do tomorrow and send it out.
