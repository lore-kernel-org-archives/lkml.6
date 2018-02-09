Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeBIT3d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:29:33 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeBIT3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:29:31 -0500
Date: Fri, 09 Feb 2018 14:29:29 -0500 (EST)
Message-Id: <20180209.142929.1888143278121723436.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH V4 2/2] ptr_ring: try vmalloc() when kmalloc() fails
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518169550-5987-2-git-send-email-jasowang@redhat.com>
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
        <1518169550-5987-2-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri,  9 Feb 2018 17:45:50 +0800

> This patch switch to use kvmalloc_array() for using a vmalloc()
> fallback to help in case kmalloc() fails.
> 
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
