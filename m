Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEPSdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:33:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEPSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:33:41 -0400
Date: Wed, 16 May 2018 14:33:39 -0400 (EDT)
Message-Id: <20180516.143339.1658512960155967463.davem@davemloft.net>
To: hpuranik@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Encapsulate sgmii ops under one
 structure
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526433053-16308-1-git-send-email-hpuranik@codeaurora.org>
References: <1526433053-16308-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemanth Puranik <hpuranik@codeaurora.org>
Date: Wed, 16 May 2018 06:40:53 +0530

> This patch introduces ops structure for sgmii, This by ensures that
> we do not need dummy functions in case of emulation platforms.
> 
> Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>

Applied to net-next.
