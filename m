Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36282156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36282156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIVERf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:17:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43166 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbeIVERf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:17:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667E118A;
        Fri, 21 Sep 2018 15:26:42 -0700 (PDT)
Received: from [10.119.48.98] (unknown [10.119.48.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C11A3F557;
        Fri, 21 Sep 2018 15:26:41 -0700 (PDT)
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
Date:   Fri, 21 Sep 2018 23:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 09/17/2018 05:43 AM, Jun Yao wrote:
> Version 5 changes:
> 	1. Correct spelling and indentation errors[1].
> 	2. Update init_mm.pgd by assembly[2].
> 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> 	   during paging_init()[3].


For the series:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
