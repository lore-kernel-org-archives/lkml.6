Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704ADECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F6D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F6D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skogtun.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeGMVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:25:43 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45516 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731871AbeGMVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:25:43 -0400
Received: from [2a01:79c:cebe:b88c:2677:3ff:fede:f540] (port=53202)
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <harald@skogtun.org>)
        id 1fe5Ja-0003Sy-9q; Fri, 13 Jul 2018 23:09:22 +0200
Subject: Re: [GIT PULL] arm64 fixes for 4.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180713131344.GH32020@arm.com>
 <CA+55aFwR2S4a=Ytb=Rk46GBBCTX=ejVyYZ6YKO63j2MrW7+Vaw@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <c779d859-6dc4-b11b-0a8d-cf3439c0ea95@skogtun.org>
Date:   Fri, 13 Jul 2018 23:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwR2S4a=Ytb=Rk46GBBCTX=ejVyYZ6YKO63j2MrW7+Vaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [2018-07-13 20:51]:

> On Fri, Jul 13, 2018 at 6:13 AM Will Deacon <will.deacon@arm.com> wrote:
>>
>> Catalin's out enjoying the sunshine, so I'm sending the fixes for a couple
>> of weeks (although there hopefully won't be any more!).
> 
> Never fear, I'm sure there won't be more than a couple of weeks of
> sunshine in the UK this summer.
> 
> That's what you were trying to say, right?
> 
>             Linus

FYI: Northern Europe has been exceptionally warm this summer.
-- 
Hilsen Harald
