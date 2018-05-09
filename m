Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbeEIHtD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:49:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58021 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933867AbeEIHs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:48:59 -0400
Date: Wed, 9 May 2018 09:48:57 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External]  Re: [PATCH 3/3] mm/page_alloc: Fix typo in debug
 info of calculate_node_totalpages
Message-ID: <20180509074857.GD32366@dhcp22.suse.cz>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-4-git-send-email-yehs1@lenovo.com>
 <20180504131854.GQ4535@dhcp22.suse.cz>
 <HK2PR03MB16841DAC9D4C5D0569676F7692850@HK2PR03MB1684.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB16841DAC9D4C5D0569676F7692850@HK2PR03MB1684.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 05-05-18 02:10:35, Huaisheng HS1 Ye wrote:
[...]
> But this printk is a relatively meaningful reference within dmesg log.
> Especially for people who doesn't have much experience, or someone
> has a plan to modify boundary of zones within free_area_init_*.

Could you be more specific please? I am not saying that the printk is
pointless but it is DEBUG and as such it doesn't give us a very good
picture.

-- 
Michal Hocko
SUSE Labs
