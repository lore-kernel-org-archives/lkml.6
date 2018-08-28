Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139CBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74B62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74B62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeH1S4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:56:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44570 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726807AbeH1S4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:56:52 -0400
Received: (qmail 3488 invoked by uid 2102); 28 Aug 2018 11:04:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Aug 2018 11:04:47 -0400
Date:   Tue, 28 Aug 2018 11:04:47 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     linux-kernel@vger.kernel.org, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/14] Convert ehci-mv to DT
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <Pine.LNX.4.44L0.1808281104250.1443-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018, Lubomir Rintel wrote:

> Hi,
> 
> This patch set makes it possible to use the Marvell EHCI driver with
> DT-based machines.
> 
> Tested on a marvell,mmp2-based OLPC XO 1.75 laptop. (With a custom
> appended DT that will be submitted in a separate patch set. The
> machine's OpenFirmware provides a device tree, but that one is too
> buggy to boot a pure marvell,mmp2 FDT kernel.)

For all the EHCI parts of this series:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

