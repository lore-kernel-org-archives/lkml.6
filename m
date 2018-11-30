Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FA52080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FA52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLAG2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:28:32 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:50107 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeLAG2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:28:32 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d67 with ME
        id 6KJ91z0030nnJME03KJ9Ps; Fri, 30 Nov 2018 20:18:12 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 30 Nov 2018 20:18:12 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, dan.j.williams@intel.com,
        vkoul@kernel.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        daniel@zonque.org, haojian.zhuang@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
        <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 30 Nov 2018 20:18:08 +0100
In-Reply-To: <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org> (Sinan Kaya's
        message of "Fri, 30 Nov 2018 10:59:34 -0500")
Message-ID: <87pnumxtlb.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sinan Kaya <okaya@kernel.org> writes:

> On 11/30/2018 10:42 AM, Yangtao Li wrote:
>> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
>> such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
>> code.
>>
>> Signed-off-by: Yangtao Li<tiny.windzz@gmail.com>
>> ---
>>   drivers/dma/amba-pl08x.c     | 14 ++------------
>>   drivers/dma/mic_x100_dma.c   | 22 +++-------------------
>>   drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
>>   drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------

For pxa_dma:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
