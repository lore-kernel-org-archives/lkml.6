Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeBCCiq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:38:46 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37961 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeBCCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:38:40 -0500
X-Google-Smtp-Source: AH8x226U222XiLdoZDTCNurfZYwUKTi536WcC32DAAs15KA3XWx9Xq/4C/UbqJ2Jv7AgRDbCAtQNRQ==
Date: Sat, 3 Feb 2018 11:38:34 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug
 198617] New: zswap causing random applications to crash)
Message-ID: <20180203023834.GA21169@jagdpanzerIV>
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
 <20180203013455.GA739@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203013455.GA739@jagdpanzerIV>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/03/18 10:34), Sergey Senozhatsky wrote:
> so we are basically looking at 4.14-rc0+
[..]
> # first bad commit: [bd4c82c22c367e068acb1ec9ec02be2fac3e09e2] mm, THP, swap: delay splitting THP after swapped out

To re-confirm, disabling CONFIG_TRANSPARENT_HUGEPAGE fixes my 4.15.0-next

	-ss
