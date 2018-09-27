Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2340C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C966215EC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLmRWLcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C966215EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeI0Shb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbeI0Shb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:37:31 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43AE9215E4;
        Thu, 27 Sep 2018 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538050770;
        bh=MAriEGAuhY2ik/iRcIXWwTEJtXsLJ8lXXbQ7eDEF/Z8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kLmRWLcc4nW6roSN8y367ugM0rm1hkPbiSFG0nHAaavMR4H8SeaEqae7YCLP4hufw
         ynnyEPzQQbHv8Bm5+Md8u6Av9DwGD2L6U4r7LA1IkiwdaQ0FnwmffA/uSQDF82Oyhy
         ZisrGsIle+oLwM5G9jjq/azdbros9y4PSWv4fdoU=
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, linux-gpio@vger.kernel.org
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
Date:   Thu, 27 Sep 2018 07:19:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 1:51 AM, Stephen Boyd wrote:
> Looks OK to me visually. I haven't tested it because I don't have access
> to the locked down hardware anymore.

Same here.  Please wait for Jeff Hugo to test it before applying.  Thanks.
