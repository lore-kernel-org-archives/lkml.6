Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E91C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B243D217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B243D217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeHUXCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:02:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36706 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:02:13 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6000E144D397B;
        Tue, 21 Aug 2018 12:40:44 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:40:43 -0700 (PDT)
Message-Id: <20180821.124043.1345592906200206631.davem@davemloft.net>
To:     rppt@linux.vnet.ibm.com
Cc:     sam@ravnborg.org, mhocko@kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] sparc32: switch to NO_BOOTMEM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Aug 2018 12:40:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon,  6 Aug 2018 13:52:32 +0300

> These patches convert sparc32 to use memblock + nobootmem.
> I've made the conversion as simple as possible, just enough to allow moving
> HAVE_MEMBLOCK and NO_BOOTMEM to the common SPARC configuration.
> 
> v2 changes:
> * split whitespace changes to a separate patch
> * address Sam's comments [1]
> 
> [1] https://lkml.org/lkml/2018/8/2/403

Series applied, thank you.
