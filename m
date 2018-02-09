Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBIAM4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:12:56 -0500
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:49710 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBIAMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:12:54 -0500
Date: Fri, 9 Feb 2018 01:12:41 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hartley <james.hartley@mips.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3 1/1] mm: page_alloc: skip over regions of invalid pfns
 on UMA
Message-ID: <20180209001241.GA28668@vmlxhi-102.adit-jv.com>
References: <20180124143545.31963-1-erosca@de.adit-jv.com>
 <20180124143545.31963-2-erosca@de.adit-jv.com>
 <20180129184746.GK21609@dhcp22.suse.cz>
 <20180203122422.GA11832@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180203122422.GA11832@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-mm community,

Everyone of you might have and probably do have more important tasks in
their queue, compared to the boot optimization discussed in this email
chain.

Still, this patch is important for our organization, our community and
our suppliers. So, I still hope that we will be able to move forward
with it somehow, especially because it has received positive feedback
from Matthew Wilcox and Pavel Tatashin. Michal Hocko suggested that a
previous version of this patch might be more appropriate due to its
simplicity and slightly better readability.

Many thanks for your participation so far.

Best regards,
Eugeniu.
