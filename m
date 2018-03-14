Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCNRRq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:17:46 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35540 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:17:44 -0400
Date: Wed, 14 Mar 2018 13:17:41 -0400 (EDT)
Message-Id: <20180314.131741.1258816057122849215.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] DPAA Ethernet fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Wed, 14 Mar 2018 08:37:27 -0500

> This patch set is addressing several issues in the DPAA Ethernet
> driver suite:
> 
>  - module unload crash caused by wrong reference to device being left
>    in the cleanup code after the DSA related changes
>  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>    module unload
>  - a couple of error counter fixes, a duplicated init in dpaa_eth.

Series applied, thank you.
