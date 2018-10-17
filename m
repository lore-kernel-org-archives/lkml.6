Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68423ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370CB2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370CB2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJQXTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:19:32 -0400
Received: from foss.arm.com ([217.140.101.70]:53552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:19:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4904480D;
        Wed, 17 Oct 2018 08:23:21 -0700 (PDT)
Received: from [10.1.196.42] (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39ECA3F59C;
        Wed, 17 Oct 2018 08:23:20 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, will.deacon@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: arm_spe: Enable automatic DT loading
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181012192409.3819792-1-jeremy.linton@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <10e23ba4-9bed-5b0c-1659-3f2c69837c06@arm.com>
Date:   Wed, 17 Oct 2018 16:23:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181012192409.3819792-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like my previous response for this patch didn't make to the list.

On 12/10/18 20:24, Jeremy Linton wrote:
> When built as a module, the spe driver isn't automatically
> loaded on DT systems. Add the MODULE_DEVICE_TABLE entry.
> 

FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
