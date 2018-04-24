Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934369AbeDXNbl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:31:41 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:46758 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeDXNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:31:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,323,1520899200";
   d="scan'208";a="52569577"
Date: Tue, 24 Apr 2018 14:31:36 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, <netdev@vger.kernel.org>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: fix xennet_start_xmit()'s
 return type
Message-ID: <20180424133135.l5kaeq7dewvytqpy@citrix.com>
References: <20180424131815.5064-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180424131815.5064-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:18:14PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
