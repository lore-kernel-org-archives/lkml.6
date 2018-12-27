Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE63C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4F22148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeL0RfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:35:15 -0500
Received: from albireo.enyo.de ([5.158.152.32]:48298 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeL0RfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:35:15 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gcZYv-0004uT-51; Thu, 27 Dec 2018 17:35:13 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gcZYv-0001TJ-0R; Thu, 27 Dec 2018 18:35:13 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Da Shi Cao <dscao999@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
Subject: Re: [BUG]Uncalibrated TSC is not accurate enough as a time keeper
References: <CAG3POBnGPabdLQ2wvJc9HTKeHszf+RytV6t+hPyh0k=hjGd+8g@mail.gmail.com>
Date:   Thu, 27 Dec 2018 18:35:13 +0100
In-Reply-To: <CAG3POBnGPabdLQ2wvJc9HTKeHszf+RytV6t+hPyh0k=hjGd+8g@mail.gmail.com>
        (Da Shi Cao's message of "Sun, 23 Dec 2018 14:56:01 +0800")
Message-ID: <874layvpny.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Da Shi Cao:

> The cpu_khz and tsc_khz are now read directly by the cpuid
> instruction, and they are deemed to be very accurate. But this is not
> the case in our situation. The OS time lags behind about 8 seconds per
> hour. The CPU information is as follows:

Is virtualization involved?  Do you use a vendor kernel?

Note that <linux-x86_64@vger.kernel.org> is more or less dead, and
your message to linux-kernel might get lost in the flood.
