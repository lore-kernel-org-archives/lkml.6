Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94426C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7120420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfAKIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:30:33 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38804 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbfAKIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:30:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TI-rBKI_1547195391;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TI-rBKI_1547195391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jan 2019 16:29:52 +0800
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1546759399-45360-1-git-send-email-zhang.jia@linux.alibaba.com>
 <20190110173249.GE6589@linux.intel.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <0fb3e7b8-5ce2-17d6-2e71-7cb5dbd1bdc2@linux.alibaba.com>
Date:   Fri, 11 Jan 2019 16:29:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190110173249.GE6589@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/11 上午1:32, Jarkko Sakkinen wrote:
> On Sun, Jan 06, 2019 at 03:23:18PM +0800, Jia Zhang wrote:
>> The sanity check would be easier, especially for the first read
>> of binary_bios_measurements from the beginning.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> 
> The cover letter is missing and commit messages do not describe
> what kind of change the commit does.

Thanks for the comments. I will send V2.

Cheers,
Jia

> 
> /Jarkko
> 
