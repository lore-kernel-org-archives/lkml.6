Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51C8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B60520844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qdk8ukw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B60520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeGaT5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:57:49 -0400
Received: from node.akkea.ca ([192.155.83.177]:56316 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGaT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:57:49 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 1C60354204A; Tue, 31 Jul 2018 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533060979; bh=BYR1NrAoEPlEtCRj+wxMYs1+ECOaJYux24YtTeMpdzY=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=qdk8ukw73Vm/UQawFQ4iJ1sGP71cVBFKMVMEDgKFOJINNFQ+h6888Hk1/5hVc8jbX
         1rk1NJ2mGzDhdam21MPaGoqUmQ18vHszgljxVCx0UBNds8fr7ZdPHTDAn0CHTk8ZJP
         oCj2uxquYrBlyD3uQ8+T2+yM10xXgkQ18tc4TOZk=
To:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/4] power: bq25890_charger.c: Add debugging output of  failed initialization
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 12:16:19 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAJKOXPeaNpdPbhJuc5FcPKdCq_FPr70_PCSuNMmZ5wJAhBXvmQ@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca>
 <20180731164316.32696-2-angus@akkea.ca>
 <CAJKOXPeaNpdPbhJuc5FcPKdCq_FPr70_PCSuNMmZ5wJAhBXvmQ@mail.gmail.com>
Message-ID: <e37abf500ce853afb24a8568b47c6679@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 10:57, Krzysztof Kozlowski wrote:
> On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> To ease adding a new part variant some debugging is handy.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> 
> You missed my tag - I already reviewed it. Unless you change
> something, the tag should be added to commit msg:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Krzysztof
> 

Hi Krzysztof,

Ooops, sorry about that.

Thanks for the review.

Angus

