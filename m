Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A86C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF440208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF440208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJPJWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 05:22:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJPJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 05:22:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 206BF1438F5A2;
        Mon, 15 Oct 2018 18:34:13 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:34:10 -0700 (PDT)
Message-Id: <20181015.183410.964515479528607918.davem@davemloft.net>
To:     robherring2@gmail.com
Cc:     sfr@canb.auug.org.au, linux@roeck-us.net,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: Tree for Oct 15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAL_Jsq+t2ZXhtzN0KnnU1jn+JZE3Spfgm8jT60jx8j8gEEKjFQ@mail.gmail.com>
References: <20181016071240.3f62816d@canb.auug.org.au>
        <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
        <CAL_Jsq+t2ZXhtzN0KnnU1jn+JZE3Spfgm8jT60jx8j8gEEKjFQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 18:34:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 20:00:24 -0500

> David, Can you revert commit 0b9871a3a8cc. I'll have to find another approach.

Ok.
