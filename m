Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeDTISm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:18:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37965 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753984AbeDTISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:18:39 -0400
X-Google-Smtp-Source: AIpwx49cCo29l6YleeZBQjqYtByJy7cQjWKz44edNanggXsZbgxhgPicYaWA3nkvw2WBaDhh8Yjkng==
Date: Fri, 20 Apr 2018 11:18:36 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180420081836.GK19578@uranus.lan>
References: <20180405182651.GM15783@uranus.lan>
 <20180420023809.GD6397@jagdpanzerIV>
 <20180420070257.GJ19578@uranus.lan>
 <20180420072903.GA594@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420072903.GA594@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 04:29:03PM +0900, Sergey Senozhatsky wrote:
> > 
> > I don't mind. Could you please make the patch on top of linux-next?
> 
> As far as I can see, it's not in linux-next yet. So the following is
> against the mmots tree. I wouldn't mind it if we could just squash the
> patches.
> 
> =======================================================================
> 
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Subject: [PATCH] prctl: Don't compile some of prctl functions when CRUI
>  disabled
> 
> CHECKPOINT_RESTORE is the only user of validate_prctl_map()
> and prctl_set_mm_exe_file(), so we can move those two under
> CONFIG_CHECKPOINT_RESTORE.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>

Thanks a lot, Sergey!
