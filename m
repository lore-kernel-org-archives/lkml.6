Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeD3Jgu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:36:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34821 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeD3Jgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:36:49 -0400
X-Google-Smtp-Source: AB8JxZrxxO7UqSHJFRb4StBMQ6mF72Ef7jIgY/1qvSbWLX70AGykCS+k8AXtrCJSc/5LbebdQVRicA==
From: Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date: Mon, 30 Apr 2018 11:36:46 +0200
To: arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: defconfig: enable THUNDER_NIC_VF
Message-ID: <20180430093645.GA9008@wintermute>
References: <20180302143737.10788-1-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302143737.10788-1-jglauber@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:37:36PM +0100, Jan Glauber wrote:
> Without this option the NIC on ThunderX1 is not coming up
> so enable it to get a working network interface.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373785c4..3594aefa496f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -197,6 +197,7 @@ CONFIG_AMD_XGBE=y
>  CONFIG_NET_XGENE=y
>  CONFIG_MACB=y
>  CONFIG_THUNDER_NIC_PF=y
> +CONFIG_THUNDER_NIC_VF=y
>  CONFIG_HNS_DSAF=y
>  CONFIG_HNS_ENET=y
>  CONFIG_E1000E=y
> -- 
> 2.7.4

Hi Arnd,

could you take this one?

thanks,
Jan
