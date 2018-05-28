Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425256AbeE1PyO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:54:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43835 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425224AbeE1PyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:54:05 -0400
Date: Mon, 28 May 2018 14:03:18 +0200
From: Michal Hocko <mhocko@kernel.org>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [lkp-robot] [mm, memcontrol]  309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Message-ID: <20180528120318.GB27180@dhcp22.suse.cz>
References: <20180528114019.GF9904@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528114019.GF9904@yexl-desktop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-05-18 19:40:19, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a +23.0% improvement of vm-scalability.throughput due to commit:
> 
> 
> commit: 309fe96bfc0ae387f53612927a8f0dc3eb056efd ("mm, memcontrol: implement memory.swap.events")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This doesn't make any sense to me. The patch merely adds an accounting.
It doesn't optimize anything. So I strongly suspect the result is just
misleading or the test (environment) misconfigured. Not the first time
I am seeing something like that I am afraid.

-- 
Michal Hocko
SUSE Labs
