Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2876BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDD721906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="kWeiIsNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeLTWI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:08:28 -0500
Received: from mail.nic.cz ([217.31.204.67]:59995 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:08:28 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 88B88600F5;
        Thu, 20 Dec 2018 23:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545343706; bh=H4JBnC6QW8uHkZCkoqXa+jUY2pFfD5NM0SL1fQgu6uw=;
        h=Date:From:To;
        b=kWeiIsNwWUi8F/MCZz6L1h9S1KiFkZn6ORW/gw7Pce6B0RU8HO12KHHGKDr9vHfXx
         Txh6+4IWBNJ5D5u3X76dKBHOY3qpOA9UHm4545MIaEGcfYn48kwkxrOcIKj8pQ/bNa
         cTKjUdGQlyABB6Abn2KRWmtzWmDr3UyBJ8+0BLLo=
Date:   Thu, 20 Dec 2018 23:08:21 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Message-ID: <20181220230821.3f21163a@nic.cz>
In-Reply-To: <20181220214447.GA18008@bogus>
References: <20181217153706.25873-1-marek.behun@nic.cz>
        <20181217153706.25873-2-marek.behun@nic.cz>
        <20181220214447.GA18008@bogus>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"  
> 
> Don't use wildcards in compatible strings.
> 

You mean that "mailbox" shouldn't be there?

Marek
