Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEECECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69825206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69825206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGRNSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:18:22 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:52104 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeGRNSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:18:22 -0400
Received: from [192.168.188.43] (i577BC191.versanet.de [87.123.193.145])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 60C6C29057A;
        Wed, 18 Jul 2018 12:40:09 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
To:     Rob Herring <robh@kernel.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-2-daniel@zonque.org>
 <20180711150157.GA18150@rob-hp-laptop>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
Date:   Wed, 18 Jul 2018 14:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711150157.GA18150@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 11, 2018 05:01 PM, Rob Herring wrote:
> On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
>> This patch adds a generic w1 bindings document that describes how w1
>> slave deviceses are grouped under master nodes. It also augments the
>> existing w1-gpio.txt document a bit.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
>>   Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
>>   2 files changed, 33 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Note that this will conflict with a unit-address fix that I have queued
> up for 4.18 (will send this week).

How would we best handle this? Sebastian, are you going to apply this 
series, and add a note to the PR for 4.19 on how to resolve the conflict?


Thanks everyone!
Daniel
