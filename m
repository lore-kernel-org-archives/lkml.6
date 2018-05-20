Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeETWXd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:23:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeETWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:23:31 -0400
Date: Sun, 20 May 2018 18:23:27 -0400 (EDT)
Message-Id: <20180520.182327.1317628777203854457.davem@davemloft.net>
To: hpuranik@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        timur@codeaurora.org
Subject: Re: [PATCH v2] net: qcom/emac: Allocate buffers from local node
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526614169-9586-1-git-send-email-hpuranik@codeaurora.org>
References: <1526614169-9586-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemanth Puranik <hpuranik@codeaurora.org>
Date: Fri, 18 May 2018 08:59:29 +0530

> Currently we use non-NUMA aware allocation for TPD and RRD buffers,
> this patch modifies to use NUMA friendly allocation.
> 
> Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
> ---
> Change since v1:
> - Addressed comments related to ordering

Applied to net-next.
