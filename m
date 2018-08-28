Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CF920893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CF920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH1TvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:51:12 -0400
Received: from foss.arm.com ([217.140.101.70]:41510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeH1TvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:51:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8493D80D;
        Tue, 28 Aug 2018 08:58:53 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.Emea.Arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93B4D3F73D;
        Tue, 28 Aug 2018 08:58:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Provide core API for NMIs
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org
References: <1535470188-38155-1-git-send-email-julien.thierry@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <43d35a78-1ab8-baca-3305-737f472ce785@arm.com>
Date:   Tue, 28 Aug 2018 16:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1535470188-38155-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/18 16:29, Julien Thierry wrote:
> Hi,
> 

[...]

> I'll soon post a series making use of the API for Arm's GICv3.
> 

Here is the series, NMI related patches are the last 4 in the series:

https://lkml.org/lkml/2018/8/28/693

-- 
Julien Thierry
