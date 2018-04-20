Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDTAtV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:49:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753825AbeDTAtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:49:20 -0400
Date: Fri, 20 Apr 2018 03:49:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, mpatocka@redhat.com,
        eric.dumazet@gmail.com, thuth@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH v2 net 0/3] virtio: ctrl buffer fixes
Message-ID: <20180420034743-mutt-send-email-mst@kernel.org>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
 <20180419.163422.299364261955942291.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419.163422.299364261955942291.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:34:22PM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Thu, 19 Apr 2018 08:30:47 +0300
> 
> > Here are a couple of fixes related to the virtio control buffer.
> > Lightly tested on x86 only.
> 
> Thanks for taking care of the control buffer DMA'ability issue.
> 
> Want any of these queued up for -stable?

Good point. Patches 1-2 for sure. 

Thanks!

-- 
MST
