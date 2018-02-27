Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeB0NzV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:55:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:58301 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932129AbeB0NzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:55:20 -0500
Date: Tue, 27 Feb 2018 14:55:17 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Gopi Sai Teja <gopi.st@samsung.com>
Cc: "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ami Prakash Asthana <prakash.a@samsung.com>,
        Lalit Mohan Tripathi <lalit.mohan@samsung.com>,
        Himanshu Shukla <himanshu.sh@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: Regarding slabinfo tool generating kernel crash
Message-ID: <20180227135517.GA29402@dhcp22.suse.cz>
References: <CGME20180226132235epcms5p2a7d2f362274ffc45198c574057ec82fb@epcms5p2>
 <20180226132235epcms5p2a7d2f362274ffc45198c574057ec82fb@epcms5p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226132235epcms5p2a7d2f362274ffc45198c574057ec82fb@epcms5p2>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-02-18 18:52:35, Gopi Sai Teja wrote:
> Hi all,
> 
> We are using slabinfo tool with -df option. Tool is generating kernel crash.
> Please help if anyone got same issue.
> 
> Our kernel image was built with poison, store_user, red_zone and sanity_checks
> enabled in slab debug.

Such a report is basically pointless without the crash report and the
kernel version which happens to be affected.

-- 
Michal Hocko
SUSE Labs
