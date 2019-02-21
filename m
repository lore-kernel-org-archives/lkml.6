Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75632070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfBUXmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:42:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBUXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:42:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C3ABC14698213;
        Thu, 21 Feb 2019 15:42:52 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:42:50 -0800 (PST)
Message-Id: <20190221.154250.888866020262496906.davem@davemloft.net>
To:     jose.abreu@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, joao.pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: Performance improvements
 in Multi-Queue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1550569066.git.joabreu@synopsys.com>
References: <cover.1550569066.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 15:42:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>
Date: Tue, 19 Feb 2019 10:38:46 +0100

> Tested in XGMAC2 and GMAC5.

Series applied, thanks Jose.
