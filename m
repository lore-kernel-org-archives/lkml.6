Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeCaOET (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:04:19 -0400
Received: from ozlabs.org ([103.22.144.67]:60823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753195AbeCaOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:04:13 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2615c93e5f52db62586112793d889face99eb905
In-Reply-To: <20180328002544.18526-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Mackerras <paulus@samba.org>, Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [v2, 1/5] powerpc: mm: Simplify page_is_ram by using memblock_is_memory
Message-Id: <40D0bH5b9gz9s1S@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:11 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 00:25:40 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> Instead of open-coding the search in page_is_ram, call memblock_is_memory.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2615c93e5f52db62586112793d889f

cheers
