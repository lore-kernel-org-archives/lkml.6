Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030317AbeCAMLQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:11:16 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:40133 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030253AbeCAMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:11:14 -0500
X-Google-Smtp-Source: AG47ELu6oI7rinhXRTQwdgc3+j/i0J9g9fu/bLE4ke/3nVUE8brhttHUiMPZQam4xnZYao/nUw8yGg==
Date: Thu, 1 Mar 2018 04:11:11 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Aaron Lu <aaron.lu@intel.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/3] mm/free_pcppages_bulk: update pcp->count inside
In-Reply-To: <20180301062845.26038-2-aaron.lu@intel.com>
Message-ID: <alpine.DEB.2.20.1803010410580.91729@chino.kir.corp.google.com>
References: <20180301062845.26038-1-aaron.lu@intel.com> <20180301062845.26038-2-aaron.lu@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Aaron Lu wrote:

> Matthew Wilcox found that all callers of free_pcppages_bulk() currently
> update pcp->count immediately after so it's natural to do it inside
> free_pcppages_bulk().
> 
> No functionality or performance change is expected from this patch.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: David Rientjes <rientjes@google.com>
