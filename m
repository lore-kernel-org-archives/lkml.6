Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4302083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfBESez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:34:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfBESey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:34:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6DB4133FABCD;
        Tue,  5 Feb 2019 10:34:53 -0800 (PST)
Date:   Tue, 05 Feb 2019 10:34:53 -0800 (PST)
Message-Id: <20190205.103453.1670645181373995149.davem@davemloft.net>
To:     moritz.fischer@ettus.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com, andrew@lunn.ch,
        robh+dt@kernel.org, mdf@kernel.org
Subject: Re: [PATCH net-next 0/3] nixge: Fixed-link support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190204173040.5538-1-moritz.fischer@ettus.com>
References: <20190204173040.5538-1-moritz.fischer@ettus.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Feb 2019 10:34:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Mon,  4 Feb 2019 09:30:37 -0800

> From: Moritz Fischer <mdf@kernel.org>
> 
> This series adds fixed-link support to nixge.
> 
> The first patch corrects the binding to correctly reflect
> hardware that does not come with MDIO cores instantiated.
> 
> The second patch adds fixed link support to the driver.
> 
> The third patch updates the binding document with the now
> optional (formerly required) phy-handle property and references
> the fixed-link docs.

Series applied, thank you.
