Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBHUdZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:33:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:33:24 -0500
Date: Thu, 08 Feb 2018 15:33:22 -0500 (EST)
Message-Id: <20180208.153322.1029603997862267638.davem@davemloft.net>
To: kvalo@codeaurora.org
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: pull-request: wireless-drivers-next 2018-02-08
From: David Miller <davem@davemloft.net>
In-Reply-To: <87shabe5a0.fsf@kamboji.qca.qualcomm.com>
References: <87shabe5a0.fsf@kamboji.qca.qualcomm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalle Valo <kvalo@codeaurora.org>
Date: Thu, 08 Feb 2018 19:54:15 +0200

> first set of fixes for 4.16, unusually many when the merge window hasn't
> even closed yet. Especially the ssb fix is important so I hope there's
> still time to get this to 4.16-rc1. As you can see from the diffstat
> there's one PCI id addition but that has been acked by Bjorn.
> 
> Please let me know if you have any problems.

Device ID additions are always ok regardless of what state of development
we are in.

Pulled, thanks Kalle.
