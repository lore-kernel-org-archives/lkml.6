Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967320AbeBOKzS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:55:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755357AbeBOKzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:55:16 -0500
Date: Thu, 15 Feb 2018 10:55:10 +0000
From: Mel Gorman <mgorman@suse.de>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        gi-oh.kim@profitbricks.com, heiko.carstens@de.ibm.com,
        baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
        paul.burton@mips.com, miles.chen@mediatek.com, vbabka@suse.cz,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/1] mm: initialize pages on demand during boot
Message-ID: <20180215105510.5md37yoqij2f663k@suse.de>
References: <20180214163343.21234-1-pasha.tatashin@oracle.com>
 <20180214163343.21234-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180214163343.21234-2-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:33:43AM -0500, Pavel Tatashin wrote:
> Deferred page initialization allows the boot cpu to initialize a small
> subset of the system's pages early in boot, with other cpus doing the rest
> later on.
> 

Bit late to the game but

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
