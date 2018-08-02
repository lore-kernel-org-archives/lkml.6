Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AB9208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AB9208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeHBJKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:10:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16303 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726106AbeHBJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:10:35 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42975806"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Aug 2018 15:20:40 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id CC6C94B66A09;
        Thu,  2 Aug 2018 15:20:40 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 2 Aug 2018 15:20:47 +0800
Subject: Re: [PATCH v4 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
To:     Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <mingo@redhat.com>, <bhe@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-4-fanc.fnst@cn.fujitsu.com>
 <18d27595-43d8-d2a0-bfdf-bd731b77d1b9@cn.fujitsu.com>
 <20180802035413.GC6723@localhost.localdomain>
 <alpine.DEB.2.21.1808020857130.1835@nanos.tec.linutronix.de>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <937d74c4-7675-4622-a72e-bb7b69ae7060@cn.fujitsu.com>
Date:   Thu, 2 Aug 2018 15:20:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808020857130.1835@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: CC6C94B66A09.AB07F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 08/02/2018 03:05 PM, Thomas Gleixner wrote:
[...]
> 
> Folks. Can you please both stop this annoying habit of keeping the full
> context of the mail and then sprinkling a random sentence into the middle?
> 

I see. won¡¯t do this stupid thing again.

Thanks,

	dou


