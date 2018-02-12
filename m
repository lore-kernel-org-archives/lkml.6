Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbeBLDez (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:34:55 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47574 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeBLDey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:34:54 -0500
Date: Sun, 11 Feb 2018 22:34:50 -0500 (EST)
Message-Id: <20180211.223450.926436849855081876.davem@davemloft.net>
To: jasowang@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com,
        ebiggers3@gmail.com
Subject: Re: [PATCH net] ptr_ring: prevent integer overflow when
 calculating size
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518319692-5421-1-git-send-email-jasowang@redhat.com>
References: <1518319692-5421-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Sun, 11 Feb 2018 11:28:12 +0800

> Switch to use dividing to prevent integer overflow when size is too
> big to calculate allocation size properly.
> 
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Fixes: 6e6e41c31122 ("ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
