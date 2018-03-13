Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeCMJtq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60449 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeCMJto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:49:44 -0400
Date: Tue, 13 Mar 2018 10:49:39 +0100
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
Subject: Re: Re: Regarding slabinfo tool generating kernel crash
Message-ID: <20180313094939.GN12772@dhcp22.suse.cz>
References: <20180227135517.GA29402@dhcp22.suse.cz>
 <20180226132235epcms5p2a7d2f362274ffc45198c574057ec82fb@epcms5p2>
 <CGME20180226132235epcms5p2a7d2f362274ffc45198c574057ec82fb@epcms5p1>
 <1923766984.282470.1519888690807.JavaMail.jboss@ep1ml502>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1923766984.282470.1519888690807.JavaMail.jboss@ep1ml502>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late reply]

On Thu 01-03-18 12:48:10, Gopi Sai Teja wrote:
> Hi all,
>  
> Please find the crash logs attached tested on 4.4.0-116-generic #140-Ubuntu.
> How to reproduce:
> 
> Boot the kernel with all slab debug flags enabled(red_zone, poison,
> sanity_checks, store_user)
> 
> and run slabinfo -df.
> 
> For more info, please check the logs.
> If more info required, please let me know

Slabs are corrupted so you should focus on who causes the corruption.
Please work with your distribution support or try to reproduce with the
current upstream kernel to get more help on the kernel mailing list.
Slabtop merely points out the problem.
-- 
Michal Hocko
SUSE Labs
