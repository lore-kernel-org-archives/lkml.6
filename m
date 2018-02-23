Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeBWRmb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:42:31 -0500
Received: from smtp.citrix.com ([66.165.176.89]:54066 "EHLO SMTP.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbeBWRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:42:29 -0500
X-IronPort-AV: E=Sophos;i="5.47,383,1515456000";
   d="scan'208";a="464227816"
Date: Fri, 23 Feb 2018 17:32:48 +0000
From: Wei Liu <wei.liu2@citrix.com>
To: Colin King <colin.king@canonical.com>
CC: Wei Liu <wei.liu2@citrix.com>, Paul Durrant <paul.durrant@citrix.com>,
        <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] xen-netback: make function xenvif_rx_skb static
Message-ID: <20180223173248.ltt2f5ek2bfzesxt@citrix.com>
References: <20180223171657.5748-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180223171657.5748-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 05:16:57PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function xenvif_rx_skb is local to the source and does not need
> to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/net/xen-netback/rx.c:422:6: warning: symbol 'xenvif_rx_skb'
> was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>

Thanks
