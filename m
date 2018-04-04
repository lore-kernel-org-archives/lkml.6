Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDDG7q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:59:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38025 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:59:45 -0400
X-Google-Smtp-Source: AIpwx4+Su4e2P6PphvyBizzHfjRoyMQqnjosAd8rge85ANqJYbRZTbgm+hdnEAdwK8rJUL0POPc1NA==
Date: Wed, 4 Apr 2018 09:59:42 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404065942.GB15783@uranus.lan>
References: <20180403223722.GA15783@uranus.lan>
 <48bcd917-4eb8-9da6-ec4b-e76a654695c4@linux.alibaba.com>
 <20180404053541.GA6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404053541.GA6312@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 07:35:41AM +0200, Michal Hocko wrote:
> > > Or we can simply drop it off because PR_SET_MM_MAP covers all needs,
> > > and I would rather prefer to do that asap.
> > 
> > Thanks for making it deprecated. I'd prefer just drop it off if nobody
> > objects. The change will get soaked in linux-next for a while , we will know
> > if it breaks compatibility (it sounds very unlikely).
> 
> Yeah, let's just drop it and have the patch in linux-next (via mmotm)
> for 2 release cycles and see whether somebody complains.
> 
> You can add
> Acked-by: Michal Hocko <mhocko@suse.com>
> for such a patch.

Sure. Thanks!
