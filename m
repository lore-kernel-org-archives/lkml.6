Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeEBOEw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:04:52 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60270 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:04:50 -0400
Date: Wed, 02 May 2018 10:04:46 -0400 (EDT)
Message-Id: <20180502.100446.106883595468297057.davem@davemloft.net>
To: mst@redhat.com
Cc: kevin@guarana.org, linux-kernel@vger.kernel.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180502162932-mutt-send-email-mst@kernel.org>
References: <20180501.140551.1944561534446599966.davem@davemloft.net>
        <20180502062809.GA14485@la.guarana.org>
        <20180502162932-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 2 May 2018 16:36:37 +0300

> Ouch.  True - and in particular the 32 bit ABI on 64 bit kernels doesn't
> work at all. Hmm. It's relatively new and maybe there aren't any 32 bit
> users yet. Thoughts?

If it's been in a released kernel version, we really aren't at liberty
to play "maybe nobody uses this" UAPI changing games.

Please send me a revert.
