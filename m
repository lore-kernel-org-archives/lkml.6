Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeEBPLw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:11:52 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeEBPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:11:50 -0400
Date: Wed, 02 May 2018 11:11:48 -0400 (EDT)
Message-Id: <20180502.111148.1024361659031057391.davem@davemloft.net>
To: keescook@chromium.org
Cc: peppe.cavallaro@st.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jose.Abreu@synopsys.com
Subject: Re: [PATCH] net: stmmac: Avoid VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180501210130.GA47709@beast>
References: <20180501210130.GA47709@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 1 May 2018 14:01:30 -0700

> In the quest to remove all stack VLAs from the kernel[1], this switches
> the "status" stack buffer to use the existing small (8) upper bound on
> how many queues can be checked for DMA, and adds a sanity-check just to
> make sure it doesn't operate under pathological conditions.
> 
> [1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to net-next, thank you.
