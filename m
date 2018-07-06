Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2985240A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2985240A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932363AbeGFFa7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:30:59 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37524 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbeGFFa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:30:58 -0400
Received: from [192.168.178.170] (pD95EF57F.dip0.t-ipconnect.de [217.94.245.127])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 37A8D28DBF7;
        Fri,  6 Jul 2018 05:30:54 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] dt-bindings: w1: document generic onewire and
 DS2760 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
References: <20180704044411.2693-1-daniel@zonque.org>
 <20180704044411.2693-2-daniel@zonque.org>
 <20180705233245.GA16422@rob-hp-laptop>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <de376c3a-9579-1f3f-26d6-b9ca367d6d40@zonque.org>
Date:   Fri, 6 Jul 2018 07:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705233245.GA16422@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 06, 2018 01:32 AM, Rob Herring wrote:
> On Wed, Jul 04, 2018 at 06:44:08AM +0200, Daniel Mack wrote:
>> This patch adds a generic w1 bindings document that merely describes how
>> slave deviceses are grouped under master nodes. It also adds a specific
>> binding for the ds2760 battery monitor.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   .../bindings/power/supply/maxim,ds2760.txt    | 29 +++++++++++++++++++
> 
> This has grown enough now, you should probably make it a separate
> patch.

Right, will do.

Thanks for all the reviews, Rob. Much appreciated. Will send a v4.


Daniel
