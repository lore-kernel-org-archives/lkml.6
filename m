Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC7120858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC7120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeKJWX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:23:56 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:47392 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbeKJWX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:23:56 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 6701719F5BA;
        Sat, 10 Nov 2018 13:38:48 +0100 (CET)
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
To:     Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin>
 <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <3f5ff18e-a264-981d-505f-69636fcf4355@free.fr>
Date:   Sat, 10 Nov 2018 13:38:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 09:57, Arnd Bergmann wrote:

> On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
>>> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
>>> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
>>>
>>
>> Looks good,
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> But I left it intentionally to avoid churn assuming it will go away when
>> ARM SoC team runs savedefconfig and sync the defconfig.
> 
> I would never do that,

Isn't that what commit c432c0880596 did? :-p

$ git show --stat c432c0880596 
 arch/arm64/configs/defconfig | 102 +++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)
