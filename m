Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeFAPsH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:48:07 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47680 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFAPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:48:04 -0400
Date: Fri, 01 Jun 2018 11:48:02 -0400 (EDT)
Message-Id: <20180601.114802.1773849900748494270.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Split the PPv2 driver to a
 dedicated directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180531080743.4218-1-maxime.chevallier@bootlin.com>
References: <20180531080743.4218-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 31 May 2018 10:07:43 +0200

> As the mvpp2 driver is growing, move this driver to a dedicated
> directory and split it into several files.
> 
> Since this driver has a lot of register defines and structure
> definitions, it can benefit from having all of this into a dedicated
> header file, named mvpp2.h.
> 
> A good chunk of the mvpp2 code is dedicated to Header Parser handling, so
> we introduce mvpp2_prs.h where all Header Parser definitions are located,
> and mvpp2_prs.c containing the related code.
> 
> In the same way, mvpp2_cls.h and mvpp2_cls.c are created to contain
> Classifier and RSS related code.
> 
> The former 'mvpp2.c' file is renamed 'mvpp2_main.c' so that we can keep
> the driver binary named 'mvpp2'.
> 
> This commit is only about spliting the driver into multiple files and
> doesn't introduce any new function, feature or fix besides removing
> 'static' keywords when needed.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> This is based on the latest net-next, I expect no conflicts but due to
> the amount of code this patchs touches, it can easily become un-appliable.
> 
> Tell me if that's the case, I'll be happy to rebase it if needed.

Applied, thank you.
