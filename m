Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDZSyT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:54:19 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:43387 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDZSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:54:17 -0400
X-Google-Smtp-Source: AB8JxZoNcRHImvOHdiIkQvn0PFSkZ2wFicUDZt8rs23weeliNNjha6j6cUGVfp5eCmQo13cm84s4FA==
Date: Thu, 26 Apr 2018 11:54:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Wang Long <wanglong19@meituan.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        khlebnikov@yandex-team.ru, xboe@kernel.dk, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, gthelen@google.com
Subject: Re: [PATCH v2] memcg: writeback: use memcg->cgwb_list directly
Message-ID: <20180426185414.GN1911913@devbig577.frc2.facebook.com>
References: <1524406173-212182-1-git-send-email-wanglong19@meituan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524406173-212182-1-git-send-email-wanglong19@meituan.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 10:09:33PM +0800, Wang Long wrote:
> mem_cgroup_cgwb_list is a very simple wrapper and it will
> never be used outside of code under CONFIG_CGROUP_WRITEBACK.
> so use memcg->cgwb_list directly.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Wang Long <wanglong19@meituan.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
