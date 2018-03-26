Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeCZVYF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:24:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeCZVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:24:03 -0400
Date: Mon, 26 Mar 2018 14:24:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
 to kernel modules
Message-Id: <20180326142400.82c7f29992c4b0c3a8f4d230@linux-foundation.org>
In-Reply-To: <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
        <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 10:39:53 +0800 Wei Wang <wei.w.wang@intel.com> wrote:

> In some usages, e.g. virtio-balloon, a kernel module needs to know if
> page poisoning is in use. This patch exposes the page_poisoning_enabled
> function to kernel modules.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
