Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A53B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A53B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeISGV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:21:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52920 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbeISGVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:21:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA3880D;
        Tue, 18 Sep 2018 17:46:44 -0700 (PDT)
Received: from [10.119.48.19] (unknown [10.119.48.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26D283F5C0;
        Tue, 18 Sep 2018 17:46:43 -0700 (PDT)
Subject: Re: [PATCH v4] EDAC, ghes: use CPER module handles to locate DIMMs
To:     Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, bp@alien8.de, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, john.garry@huawei.com,
        toshi.kani@hpe.com, tanxiaofei@huawei.com, wanghuiqiang@huawei.com,
        shiju.jose@huawei.com
References: <1536067493-31454-1-git-send-email-wufan@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <33dde632-3ab9-cab3-38cc-cc841a9e88e2@arm.com>
Date:   Wed, 19 Sep 2018 01:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1536067493-31454-1-git-send-email-wufan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

On 09/04/2018 02:24 PM, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
