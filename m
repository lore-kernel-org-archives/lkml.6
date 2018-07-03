Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0947C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CF62064D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CF62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbeGCQdz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:33:55 -0400
Received: from foss.arm.com ([217.140.101.70]:52404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:33:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A083A7A9;
        Tue,  3 Jul 2018 09:33:54 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317433F5BA;
        Tue,  3 Jul 2018 09:33:52 -0700 (PDT)
Subject: Re: [PATCH v10 06/14] arm64: cpufeature: add MMFR0 helper functions
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-7-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <3c8d8639-a48b-05b2-5554-bd001d914638@arm.com>
Date:   Tue, 3 Jul 2018 17:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-7-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Those helper functions for MMFR0 register will be used later by kexec_file
> loader.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
