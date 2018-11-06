Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B55C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33CD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33CD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeKFSqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:46:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57414 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFSqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:46:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266B280D;
        Tue,  6 Nov 2018 01:21:54 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167693F5BD;
        Tue,  6 Nov 2018 01:21:52 -0800 (PST)
Subject: Re: [PATCH 1/3] coresight: etb10: Add support for CLAIM tag
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <39da792f-4197-21f9-74ae-d4c1658150a8@arm.com>
Date:   Tue, 6 Nov 2018 09:21:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 05/11/2018 22:26, Mathieu Poirier wrote:
> Following in the footstep of what was done for other CoreSight devices,
> add CLAIM tag support to ETB10 in order to synchronise access to the
> HW between the kernel and an external agent.
> 

Thanks for spotting this. Somehow I missed the etb10 in the original
series.

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
