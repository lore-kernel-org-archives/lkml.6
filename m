Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeEBOTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:19:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751602AbeEBOT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:19:28 -0400
Date: Wed, 2 May 2018 17:19:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: kevin@guarana.org, linux-kernel@vger.kernel.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
Message-ID: <20180502171909-mutt-send-email-mst@kernel.org>
References: <20180501.140551.1944561534446599966.davem@davemloft.net>
 <20180502062809.GA14485@la.guarana.org>
 <20180502162932-mutt-send-email-mst@kernel.org>
 <20180502.100446.106883595468297057.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502.100446.106883595468297057.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 10:04:46AM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 2 May 2018 16:36:37 +0300
> 
> > Ouch.  True - and in particular the 32 bit ABI on 64 bit kernels doesn't
> > work at all. Hmm. It's relatively new and maybe there aren't any 32 bit
> > users yet. Thoughts?
> 
> If it's been in a released kernel version, we really aren't at liberty
> to play "maybe nobody uses this" UAPI changing games.
> 
> Please send me a revert.

Sent. Looking at compat mess now.

-- 
MST
