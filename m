Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7AC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD34215E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD34215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHSIpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 04:45:17 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:48170 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeHSIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 04:45:16 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w7J5YUCl085926;
        Sat, 18 Aug 2018 22:34:33 -0700
Message-ID: <5B790166.8070008@tlinx.org>
Date:   Sat, 18 Aug 2018 22:34:30 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Linux-Kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: problem in building 4.8.0: references to non-existent util CLANG
References: <5B78BE6E.3080107@tlinx.org> <631cc19b-f8c0-7e07-a60f-fcd52e8a8564@infradead.org>
In-Reply-To: <631cc19b-f8c0-7e07-a60f-fcd52e8a8564@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On 08/18/2018 05:48 PM, Linda Walsh wrote:
>   
>> Is CLANG required for building now?
>>     
> Looks like this patch should fix it:
> https://marc.info/?l=linux-kbuild&m=153447099313149&w=2
>   
---
      Thanks much!


