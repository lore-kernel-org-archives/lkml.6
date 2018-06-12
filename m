Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2BC83C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19102086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19102086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934938AbeFLWgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:36:43 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeFLWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:36:41 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 80BF5100AB029;
        Tue, 12 Jun 2018 15:36:40 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:36:40 -0700 (PDT)
Message-Id: <20180612.153640.206354770292248454.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, carlo@caione.org, khilman@baylibre.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-meson8b: Fix an error handling path
 in 'meson8b_dwmac_probe()'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
References: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Jun 2018 15:36:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 11 Jun 2018 19:52:27 +0200

> If 'of_device_get_match_data()' fails, we need to release some resources as
> done in the other error handling path of this function.
> 
> Fixes: efacb568c962 ("net: stmmac: dwmac-meson: extend phy mode setting")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.
