Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeEBO1r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:27:47 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeEBO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:27:44 -0400
Date: Wed, 02 May 2018 10:27:43 -0400 (EDT)
Message-Id: <20180502.102743.390991677723394659.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Revert "vhost: make msg padding explicit"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525270740-460646-1-git-send-email-mst@redhat.com>
References: <1525270740-460646-1-git-send-email-mst@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 2 May 2018 17:19:05 +0300

> This reverts commit 93c0d549c4c5a7382ad70de6b86610b7aae57406.
> 
> Unfortunately the padding will break 32 bit userspace.
> Ouch. Need to add some compat code, revert for now.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks Michael.
