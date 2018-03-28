Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeC1M6f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 08:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51923 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbeC1M6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 08:58:32 -0400
Date: Wed, 28 Mar 2018 14:58:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Austin Kim <austincrashtool@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOg==?= Too easy OOM
Message-ID: <20180328125830.GA8976@dhcp22.suse.cz>
References: <2AD939572F25A448A3AE3CAEA61328C23750D4E0@BC-MAIL-M28.internal.baidu.com>
 <CAKEcN828eqXN8zhKgzu+Mf-vdXC8o_LOmxwWZ4vayrdvmpdPFQ@mail.gmail.com>
 <2AD939572F25A448A3AE3CAEA61328C237512B38@BC-MAIL-M28.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C237512B38@BC-MAIL-M28.internal.baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-03-18 01:34:24, Li,Rongqing wrote:
> OK, I see this commit, I will test the latest kernel
> 
> commit 1c610d5f93c709df56787f50b3576704ac271826
> Author: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Date:   Thu Mar 22 16:17:42 2018 -0700

Yes, that should fix your memcg OOM
-- 
Michal Hocko
SUSE Labs
