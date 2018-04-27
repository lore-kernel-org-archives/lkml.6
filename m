Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758522AbeD0TLj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:11:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758075AbeD0TLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:11:36 -0400
Date: Fri, 27 Apr 2018 15:11:34 -0400 (EDT)
Message-Id: <20180427.151134.218294135260092691.davem@davemloft.net>
To: bjorn.andersson@linaro.org
Cc: clew@codeaurora.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] net: qrtr: Expose tunneling endpoint to user space
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427052849.24899-1-bjorn.andersson@linaro.org>
References: <20180427052849.24899-1-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Thu, 26 Apr 2018 22:28:49 -0700

> This implements a misc character device named "qrtr-tun" for the purpose
> of allowing user space applications to implement endpoints in the qrtr
> network.
> 
> This allows more advanced (and dynamic) testing of the qrtr code as well
> as opens up the ability of tunneling qrtr over a network or USB link.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied to net-next, thank you.
