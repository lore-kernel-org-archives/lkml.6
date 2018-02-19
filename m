Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeBSSNO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:13:14 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:45524 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbeBSSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:13:12 -0500
Subject: Re: [PATCH net-next 0/7] stmmac multi-queue fixes and cleanups
To: Niklas Cassel <niklas.cassel@axis.com>, <netdev@vger.kernel.org>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
CC: <Jose.Abreu@synopsys.com>, <vbhadram@nvidia.com>,
        Niklas Cassel <niklass@axis.com>, <linux-kernel@vger.kernel.org>
From: Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <5a7aa80d-aa5d-ee92-8e39-3cf8e0f6c24e@synopsys.com>
Date: Mon, 19 Feb 2018 18:12:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.66]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 19-02-2018 17:11, Niklas Cassel wrote:
> stmmac multi-queue fixes and cleanups
>
> Niklas Cassel (7):
>   net: stmmac: set MSS for each tx DMA channel
>   net: stmmac: do not clear tx_skbuff entries in
>     stmmac_xmit()/stmmac_tso_xmit()
>   net: stmmac: WARN if tx_skbuff entries are reused before cleared
>   net: stmmac: rename dwmac4_tx_queue_routing() to match reality
>   net: stmmac: call correct function in
>     stmmac_mac_config_rx_queues_routing()
>   net: stmmac: add error handling in stmmac_mtl_setup()
>   net: stmmac: honor error code from stmmac_dt_phy()

Thanks! The whole series is:

Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Best Regards,
Jose Miguel Abreu

>
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  6 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 23 +++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 34 +++++++++++++++++-----
>  4 files changed, 42 insertions(+), 23 deletions(-)
>
