Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeEARTW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:19:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753505AbeEARTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:19:20 -0400
Date: Tue, 1 May 2018 20:19:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, kevin@guarana.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
Message-ID: <20180501201841-mutt-send-email-mst@kernel.org>
References: <1524844881-178524-1-git-send-email-mst@redhat.com>
 <20180501.112822.1871426720257639849.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501.112822.1871426720257639849.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 11:28:22AM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Fri, 27 Apr 2018 19:02:05 +0300
> 
> > There's a 32 bit hole just after type. It's best to
> > give it a name, this way compiler is forced to initialize
> > it with rest of the structure.
> > 
> > Reported-by: Kevin Easton <kevin@guarana.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Michael, will you be sending this directly to Linus or would you like
> me to apply it to net or net-next?
> 
> Thanks.

I'd prefer you to apply it for net and cc stable if possible.
Thanks!

-- 
MST
