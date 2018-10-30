Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB408C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DB92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DB92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeJ3Mnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:43:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45458 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJ3Mnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:43:52 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9F7A13ADD5FB;
        Mon, 29 Oct 2018 20:52:08 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:52:08 -0700 (PDT)
Message-Id: <20181029.205208.1428877680359888900.davem@davemloft.net>
To:     ndesaulniers@google.com
Cc:     aviad.krawczyk@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com
Subject: Re: [PATCH] hinic: Fix l4_type parameter in
 hinic_task_set_tunnel_l4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAKwvOdkg=4BnDKVSuZ0ag4n2G0brL7XS1NL3u9D9mwxaP-6dfA@mail.gmail.com>
References: <20181029105158.6340-1-natechancellor@gmail.com>
        <CAKwvOdmkPFC5SPNVTXeRdrE-vnbjYiDdXr_ZCArmvYYVtsYKVQ@mail.gmail.com>
        <CAKwvOdkg=4BnDKVSuZ0ag4n2G0brL7XS1NL3u9D9mwxaP-6dfA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 20:52:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 29 Oct 2018 10:35:01 -0700

> So I think we'll need you to merge up Nathan's patch.  Is there
> anything additional to mark this driver as unmaintained in
> MAINTAINERS?

Just submit a patch stating as such if you cannot reach any of
the listed maintainters.
