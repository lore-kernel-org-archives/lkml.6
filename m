Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeCFWsf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:48:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeCFWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:48:33 -0500
Date: Tue, 6 Mar 2018 14:48:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, mhocko@suse.com,
        jack@suse.cz, kirill.shutemov@linux.intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org, hughd@google.com,
        n-horiguchi@ah.jp.nec.com, mgorman@suse.de, jglisse@redhat.com,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        anthony.yznaga@oracle.com, nadav.amit@gmail.com, zi.yan@cs.rutgers.edu,
        aarcange@redhat.com, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, henry.willard@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v12 08/11] mm: Clear arch specific VM flags on
 protection change
Message-Id: <20180306144814.86eac0c28e98b50d550fc2fd@linux-foundation.org>
In-Reply-To: <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
        <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 10:15:50 -0700 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> When protection bits are changed on a VMA, some of the architecture
> specific flags should be cleared as well. An examples of this are the
> PKEY flags on x86. This patch expands the current code that clears
> PKEY flags for x86, to support similar functionality for other
> architectures as well.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Acked-by: Andrew Morton <akpm@linux-foundation.org>
