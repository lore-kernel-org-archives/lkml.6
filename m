Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933881AbeEWRiD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:38:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60376 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:38:00 -0400
Date: Wed, 23 May 2018 13:37:58 -0400 (EDT)
Message-Id: <20180523.133758.2273298453278600346.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V2 0/4] Fix several issues of virtio-net mergeable
 XDP
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 May 2018 11:44:27 +0800

> Please review the patches that tries to fix sevreal issues of
> virtio-net mergeable XDP.
> 
> Changes from V1:
> - check against 1 before decreasing instead of resetting to 1
> - typoe fixes

Series applied and queued up for -stable.
