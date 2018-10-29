Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20482C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32122082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32122082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJ3C3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:29:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeJ3C3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:29:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B12DE136DD16E;
        Mon, 29 Oct 2018 10:40:09 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:40:08 -0700 (PDT)
Message-Id: <20181029.104008.791032322062574758.davem@davemloft.net>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
References: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
        <20181029130331.GC21857@kernel.org>
        <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 10:40:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>
Date: Mon, 29 Oct 2018 10:33:06 -0400

> I just realized that the problem in KNL will be back if we switch
> back to non-overwrite mode.

What is KNL?
