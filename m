Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755383AbeD3XPS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:15:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeD3XPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:15:16 -0400
Date: Mon, 30 Apr 2018 16:15:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, igor.stoppa@huawei.com
Subject: Re: [PATCH 0/2] mm: tweaks for improving use of vmap_area
Message-Id: <20180430161515.118e6538e4d4f1cc4ae425cc@linux-foundation.org>
In-Reply-To: <20180426234243.22267-1-igor.stoppa@huawei.com>
References: <20180426234243.22267-1-igor.stoppa@huawei.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 03:42:41 +0400 Igor Stoppa <igor.stoppa@gmail.com> wrote:

> These two patches were written in preparation for the creation of
> protectable memory, however their use is not limited to pmalloc and can
> improve the use of virtally contigous memory.
> 
> The first provides a faster path from struct page to the vm_struct that
> tracks it.
> 
> The second patch renames a single linked list field inside of vmap_area.
> The list is currently used only for disposing of the data structure, once
> it is not in use anymore.
> Which means that it cold be used for other purposes while it'not queued
> for destruction.

The patches look benign to me (feel free to add my ack), but I'm not
seeing a reason to apply them at this time?
