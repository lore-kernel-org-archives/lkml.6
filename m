Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeEVTke (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:40:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46846 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbeEVTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:40:32 -0400
Date: Tue, 22 May 2018 15:40:30 -0400 (EDT)
Message-Id: <20180522.154030.1125958648647752585.davem@davemloft.net>
To: chenbo@pdx.edu
Cc: pcnet32@frontier.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcnet32: add an error handling path in
 pcnet32_probe_pci()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180521214449.18516-1-chenbo@pdx.edu>
References: <20180521214449.18516-1-chenbo@pdx.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>
Date: Mon, 21 May 2018 14:44:49 -0700

> Make sure to invoke pci_disable_device() when errors occur in
> pcnet32_probe_pci().
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

Applied, thank you.
