Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5AAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F49620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeGYWG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:06:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbeGYWG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:06:26 -0400
Received: from localhost (unknown [172.58.43.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA1D3124391AD;
        Wed, 25 Jul 2018 13:53:00 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:52:59 -0700 (PDT)
Message-Id: <20180725.135259.776764053086649839.davem@davemloft.net>
To:     helgaas@kernel.org
Cc:     jdmason@kudzu.us, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: Remove unnecessary include of
 <linux/pci_hotplug.h>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 13:53:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 23 Jul 2018 15:59:46 -0500

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
> the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to net-next, thanks.
