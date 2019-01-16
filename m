Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D113520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403829AbfAPJLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:11:10 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:7089 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfAPJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:11:10 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 7044513F8C4;
        Wed, 16 Jan 2019 10:10:40 +0100 (CET)
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
Cc:     David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
Date:   Wed, 16 Jan 2019 10:10:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228160546.GC25288@hector.attlocal.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2018 17:05, Andy Gross wrote:

> On Fri, Dec 21, 2018 at 11:13:18AM +0100, Marc Gonzalez wrote:
>
>> The private copy of readl_poll_timeout is no longer needed.
>> Use the implementation in iopoll.h instead.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Reviewed-by: Andy Gross <andy.gross@linaro.org>

Would this patch go through your tree or Kishon's tree?

Regards.
