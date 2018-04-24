Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeDXSJ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:09:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43113 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDXSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:09:25 -0400
X-Google-Smtp-Source: AB8JxZpxeIJIAjx4vXVCpwfBlgEE2QZxon7ZZwVBMKI83pcvbidZs0VbDrOSCifPNgCALhZLoCxlUA==
Date: Tue, 24 Apr 2018 11:09:21 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Simon Horman <simon.horman@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Pablo =?UTF-8?B?Q2FzY8Ozbg==?= <pablo.cascon@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: nfp: fix nfp_net_tx()'s return type
Message-ID: <20180424110921.24c3699b@cakuba.netronome.com>
In-Reply-To: <20180424131710.4206-1-luc.vanoostenryck@gmail.com>
References: <20180424131710.4206-1-luc.vanoostenryck@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 15:17:07 +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
