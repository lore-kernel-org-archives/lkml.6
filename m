Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeDBPOi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:14:38 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:38424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeDBPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:14:36 -0400
Date: Mon, 02 Apr 2018 11:14:34 -0400 (EDT)
Message-Id: <20180402.111434.124774623285634501.davem@davemloft.net>
To: Jisheng.Zhang@synaptics.com
Cc: thomas.petazzoni@bootlin.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] net: mvneta: improve suspend/resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180402112229.508e1feb@xhacker.debian>
References: <20180402112229.508e1feb@xhacker.debian>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Mon, 2 Apr 2018 11:22:29 +0800

> This series tries to optimize the mvneta's suspend/resume
> implementation by only taking necessary actions.
> 
> Since v2:
>  - keep rtnl lock when calling mvneta_start_dev() and mvneta_stop_dev()
>    Thank Russell for pointing this out
> 
> Since v1:
>  - unify ret check
>  - try best to keep the suspend/resume behavior
>  - split txq deinit into sw/hw parts as well
>  - adjust mvneta_stop_dev() location

Series applied, thank you.
