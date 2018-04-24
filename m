Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758137AbeDXNU3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:20:29 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:45808 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758090AbeDXNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:20:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,323,1520899200";
   d="scan'208";a="52568284"
Date: Tue, 24 Apr 2018 14:20:23 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Wei Liu <wei.liu2@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] xen-netback: fix xenvif_start_xmit()'s return type
Message-ID: <20180424132023.pwncbjdzgqcpp7w6@citrix.com>
References: <20180424131812.5014-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180424131812.5014-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:18:12PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>
