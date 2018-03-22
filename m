Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCVWgj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:36:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:36:38 -0400
Date: Thu, 22 Mar 2018 15:36:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 04/15] mm/hmm: unregister mmu_notifier when last HMM
 client quit v3
Message-Id: <20180322153636.ad972fb547d3ff4f47498cd1@linux-foundation.org>
In-Reply-To: <20180322013025.7008-1-jglisse@redhat.com>
References: <20180321181614.9968-1-jglisse@redhat.com>
        <20180322013025.7008-1-jglisse@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 21:30:25 -0400 jglisse@redhat.com wrote:

> This code was lost in translation at one point. This properly call
> mmu_notifier_unregister_no_release() once last user is gone. This
> fix the zombie mm_struct as without this patch we do not drop the
> refcount we have on it.

OK, I'm officially all messed up and confused ;) I'll await the next
full resend, please.
