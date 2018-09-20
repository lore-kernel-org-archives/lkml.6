Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1618821529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1618821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeITRxH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:53:07 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:44932 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeITRxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:53:07 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8KC9rPQ006309;
        Thu, 20 Sep 2018 13:09:53 +0100
Date:   Thu, 20 Sep 2018 13:09:52 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Brian Dodge <bdodge09@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: arc vendor prefix
Message-ID: <20180920130952.7eb8e45c@alans-desktop>
In-Reply-To: <527da392-9629-792b-08cc-970ffc8173ee@gmail.com>
References: <527da392-9629-792b-08cc-970ffc8173ee@gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 21:05:20 -0400
Brian Dodge <bdodge09@gmail.com> wrote:

> Hi,
> 
> In the linux kernel commit 91ab076e3a2f092254fe5231bbfa92b37fd52e38 the 
> vendor prefix "arctic" was added to vendor-prefixes.txt.
> 
> The original change I authored used "arc" not "arctic", and the device 
> tree bindings were added assuming that prefix in commit 
> ce9d22573d85341c987f997461ac712e4dbe47b1
> 
> Perhaps odeju changed the name to arctic in the patch after I created it 
> and before it was approved.
> 
> This pairing isn't really compatible is it?  Either the prefix should be 
> reverted to "arc" or the bindings (and driver source) changed to use 
> "arctic", as in "arctic,arc2c0608" vs. "arc,arc2c0608"

ARC is a Synopsys registered trademark for the ARC processor line. I'm not
sure what the right answer is but I think it might be better to keep to
arctic to avoid confusion with arc based products.

Alan
