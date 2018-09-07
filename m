Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE169C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866982075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866982075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIGWNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:13:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeIGWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:13:13 -0400
Received: from localhost (unknown [172.58.40.83])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A27EE1449DA03;
        Fri,  7 Sep 2018 10:31:15 -0700 (PDT)
Date:   Fri, 07 Sep 2018 10:31:12 -0700 (PDT)
Message-Id: <20180907.103112.1943018536705670414.davem@davemloft.net>
To:     jacob.e.keller@intel.com
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, andrewx.bowers@intel.com
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <02874ECE860811409154E81DA85FBB5884C7B651@ORSMSX115.amr.corp.intel.com>
References: <20180903094702.3e32d8f5@canb.auug.org.au>
        <20180907102055.001777b8@canb.auug.org.au>
        <02874ECE860811409154E81DA85FBB5884C7B651@ORSMSX115.amr.corp.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 10:31:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Date: Fri, 7 Sep 2018 15:30:42 +0000

> There's some discussion about this going on in the intel-wired-lan
> mailing list.

I really want to see a pull request in my inbox fixing this by the end
of today or I'll apply a fix directly at my discretion.
