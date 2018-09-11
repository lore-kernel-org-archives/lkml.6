Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944BD20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944BD20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeILE7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:59:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeILE7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:59:20 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE88C128F4EA1;
        Tue, 11 Sep 2018 16:57:39 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:57:39 -0700 (PDT)
Message-Id: <20180911.165739.2032677219588723041.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     Jason@zx2c4.com, ebiggers@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, luto@kernel.org, sneves@dei.uc.pt,
        jeanphilippe.aumasson@gmail.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180911233015.GD11474@lunn.ch>
References: <20180911214737.GA81235@gmail.com>
        <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
        <20180911233015.GD11474@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Sep 2018 16:57:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 12 Sep 2018 01:30:15 +0200

> Just as an FYI:
> 
> 1) I don't think anybody in netdev has taken a serious look at the
> network code yet. There is little point until the controversial part
> of the code, Zinc, has been sorted out.
> 
> 2) I personally would be surprised if DaveM took this code without
> having an Acked-by from the crypto subsystem people. In the same way,
> i doubt the crypto people would take an Ethernet driver without having
> DaveM's Acked-by.

Both of Andrew's statements are completely true.

I'm not looking at any of the networking bits until the crypto stuff
is fully sorted and fully supported and Ack'd by crypto folks.
