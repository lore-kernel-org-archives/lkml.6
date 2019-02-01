Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615532084A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfBAAik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:38:40 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:34874 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfBAAik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:38:40 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id x110cFwp028415;
        Fri, 1 Feb 2019 11:38:21 +1100
Received: from 1.128.106.167 ([1.128.106.167]) by www.aussec.com (Horde
 Framework) with HTTP; Fri, 01 Feb 2019 11:38:10 +1100
Message-ID: <20190201113810.14475v63z28pjzsi@www.aussec.com>
Date:   Fri, 01 Feb 2019 11:38:10 +1100
From:   tom burkart <tom@aussec.com>
To:     Joe Perches <joe@perches.com>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH v14 0/3] PPS: pps-gpio PPS ECHO implementation
References: <20190129124357.17396k708szaibbx@www.aussec.com>
 <7abdee30-91fb-4d11-52e1-1778e418c7b8@enneenne.com>
 <20190131124008.64023l78rw406lfc@www.aussec.com>
 <df314ee9176095b5d59af8659c95a274fb0613c4.camel@perches.com>
In-Reply-To: <df314ee9176095b5d59af8659c95a274fb0613c4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joe Perches <joe@perches.com>:

> On Thu, 2019-01-31 at 12:40 +1100, tom burkart wrote:
>> Quoting Rodolfo Giometti <giometti@enneenne.com>:
>> --------
>> Subject	Re: [PATCH v14 2/3] dt-bindings: pps: pps-gpio PPS ECHO  
>> implementation
>>
>> I think this patch it's OK but I'm asking to myself if it should be
>> merged with
>> next one... logically it describes what patch 3/3 does so why do we  
>> keep them
>> separated?
>> -------
>> I have separated it because scripts/checkpatch.pl insists it needs to
>> be separated.
>
> checkpatch doesn't insist on anything.  It's a stupid script.
>
> Always prefer your best judgment over a stupid script.

Further references:

 From Documentation/devicetree/bindings/submitting-patches.txt:

1) The Documentation/ and include/dt-bindings/ portion of the patch should
      be a separate patch. The preferred subject prefix for binding patches is:

      "dt-bindings: <binding dir>: ..."

Tom

