Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14723C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C5E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C5E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeFTGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:37:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56170 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeFTGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:37:08 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19ED8146228F4;
        Tue, 19 Jun 2018 23:37:05 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:37:02 +0900 (KST)
Message-Id: <20180620.153702.722024386627396392.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     keescook@chromium.org, linus.walleij@linaro.org,
        pramod.kumar@broadcom.com, f.fainelli@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mdio-mux-gpio: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180620063248.GA9303@lunn.ch>
References: <20180530205712.GB16286@lunn.ch>
        <CAGXu5j+sh-gSXvGg25oN9Xsyw1W=i177=52ZXPV3OvEym6nr7g@mail.gmail.com>
        <20180620063248.GA9303@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 23:37:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 20 Jun 2018 08:32:48 +0200

> Does it cleanly apply to net-next?

net-next is closed, so net-next submissions should be sent when it
opens back up which should be some time this weekend.

Anything not in "Under Review" state in patchwork always must
be resubmitted at the appropriate time.
