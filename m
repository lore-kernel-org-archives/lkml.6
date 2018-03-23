Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeCWRQ7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:16:59 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44156 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:16:58 -0400
Date: Fri, 23 Mar 2018 13:16:56 -0400 (EDT)
Message-Id: <20180323.131656.2151525994998240049.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
References: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
        <20180323.130418.2223623186761161723.davem@davemloft.net>
        <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 13:13:46 -0400

> We have decided to drop a similar patch on Infiniband due to incorrect
> usage of barrier(). If you feel strongly about it, I can remove the
> DOORBELL change.

Either remove the DOORBELL change or properly adjust the barrier() to
be a wmb().

Be sure to mention this in the commit message, explicitly.

Thank you.
