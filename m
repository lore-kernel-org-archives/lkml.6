Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDDP7E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:59:04 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35098 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeDDP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:59:03 -0400
X-Google-Smtp-Source: AIpwx48B1LMmACd5WJsv+qwXM42x5gDSPFg/z/ljtxPQKVxYX9ckSn1obGT0PsztOP+tzOvcAa84jg==
Date: Wed, 4 Apr 2018 18:58:59 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404155857.GE15783@uranus.lan>
References: <20180403223722.GA15783@uranus.lan>
 <48bcd917-4eb8-9da6-ec4b-e76a654695c4@linux.alibaba.com>
 <20180404053541.GA6312@dhcp22.suse.cz>
 <40dde421-5300-b11f-860a-cf19aea00ec9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40dde421-5300-b11f-860a-cf19aea00ec9@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 08:54:59AM -0700, Yang Shi wrote:
> > Yeah, let's just drop it and have the patch in linux-next (via mmotm)
> > for 2 release cycles and see whether somebody complains.
> 
> BTW, I will do my v3 on top of the patch (drop off prctl_set_mm).

Sorry for delay, will do in a couple of hours.
