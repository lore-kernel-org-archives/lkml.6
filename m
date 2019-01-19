Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD42C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfASIoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:44:22 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:47089 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfASIoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:44:21 -0500
Subject: Re: bisected: ttyS panic on pa-risc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>
References: <af9136a8-ae68-5e69-1c1a-001221bb3958@linux.ee>
 <20190118122323.GA11909@kroah.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <b065a203-a65a-a4d0-486a-504964298d94@linux.ee>
Date:   Sat, 19 Jan 2019 10:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122323.GA11909@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below was just applied to my tree, hopefully ti fixes this
> issue.

Yes, it cures both the HP A500 (parisc) and HP RX2620 (ia64) that I also found breaking meanwhile.

-- 
Meelis Roos <mroos@linux.ee>
