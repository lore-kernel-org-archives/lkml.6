Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E272087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfBDROG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:14:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53900 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfBDROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:14:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AF52210895BC6;
        Mon,  4 Feb 2019 09:14:04 -0800 (PST)
Date:   Mon, 04 Feb 2019 09:14:04 -0800 (PST)
Message-Id: <20190204.091404.1919705205267977389.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        alex.williams@ni.com, robh+dt@kernel.org
Subject: Re: [net-next RFC/PATCH] net: nixge: Make mdio child node optional
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190204145854.GD22111@lunn.ch>
References: <20190202025048.14772-1-mdf@kernel.org>
        <20190204145854.GD22111@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Feb 2019 09:14:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 4 Feb 2019 15:58:54 +0100

> On Fri, Feb 01, 2019 at 06:50:48PM -0800, Moritz Fischer wrote:
>> Make MDIO child optional and only instantiate the
>> MDIO bus if the child is actually present.
>> 
>> There are currently no (in-tree) users of this
>> binding; all (out-of-tree) users use overlays that
>> get shipped together with the FPGA images that contain
>> the IP.
>> 
>> This will significantly increase maintainabilty
>> of future revisions of this IP.
>> 
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Rob Herring <robh+dt@kernel.org>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Moritz, please repost without the RFC tag and with Andrew's tag added.

Thanks.
