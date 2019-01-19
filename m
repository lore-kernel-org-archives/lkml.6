Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E542086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfASHss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 02:48:48 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50715 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfASHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 02:48:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TIYS-NP_1547884121;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIYS-NP_1547884121)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Jan 2019 15:48:42 +0800
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
 <20190116220952.GH25803@linux.intel.com>
 <8709dd61-2422-1c20-9937-d6003fa0354e@linux.alibaba.com>
 <20190118151827.GK4080@linux.intel.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <17ea25ab-9af8-87de-96e5-3dfdb24b12cb@linux.alibaba.com>
Date:   Sat, 19 Jan 2019 15:48:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190118151827.GK4080@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/18 下午11:18, Jarkko Sakkinen wrote:
> On Thu, Jan 17, 2019 at 09:32:55AM +0800, Jia Zhang wrote:
>>
>>
>> On 2019/1/17 上午6:09, Jarkko Sakkinen wrote:
>>> Please use "tpm:" tag for commits, not "tpm/eventlog/tpm1".
>>>

... snipped

> 
> OK, got it now. I think I will apply this! Will take a while because
> of https://lkml.org/lkml/2019/1/18/485. Will not apply new patches
> before that is rooted.

No problem. Thanks for your reviews.

Cheers,
Jia

> 
> /Jarkko
> 
