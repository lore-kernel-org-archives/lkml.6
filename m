Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C71C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC902064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC902064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJWLo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:44:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40350 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:44:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87142146C834C;
        Mon, 22 Oct 2018 20:23:34 -0700 (PDT)
Date:   Mon, 22 Oct 2018 20:23:33 -0700 (PDT)
Message-Id: <20181022.202333.713125643948482516.davem@davemloft.net>
To:     thor.thayer@linux.intel.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] net: stmmac: Set OWN bit for jumbo frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1540246946-12784-2-git-send-email-thor.thayer@linux.intel.com>
References: <1540246946-12784-1-git-send-email-thor.thayer@linux.intel.com>
        <1540246946-12784-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 20:23:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: thor.thayer@linux.intel.com
Date: Mon, 22 Oct 2018 17:22:26 -0500

> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Ping with Jumbo packet does not reply and get a watchdog timeout
 ...
> Inspection of queue showed Jumbo packets were not sent out.
> The ring Jumbo packet function needs to set the OWN bit so
> the packet is sent.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Add fix for jumbo frames > 8K (same OWN bit)

Applied.
