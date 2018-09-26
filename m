Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FAF21557
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FAF21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeI0Dwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:52:38 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37160 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeI0Dwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D0BB241DFF;
        Wed, 26 Sep 2018 21:37:40 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lfUa6BhgH7eI; Wed, 26 Sep 2018 21:37:40 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id BC90141DF5;
        Wed, 26 Sep 2018 21:37:34 +0000 (UTC)
Subject: Re: [V3 PATCH 0/2] selftests: watchdog: Add get/set/pre timeout
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <6f3a8fe3-1ec4-ed8b-99a2-1dba7553c1fc@kernel.org>
Date:   Wed, 26 Sep 2018 15:37:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 03:23 PM, Jerry Hoemann wrote:
> Add command line arguments to call ioctl WDIOC_GETTIMEOUT,
> WDIOC_GETPRETIMEOUT and WDIOC_SETPRETIMEOUT.
> 
> Changes  v2
> 1) Update usage to include argument
> 2) Update usage to give example.
> 3) Made printf of WDIOC_GETTIMEOUT distinct from WDIOC_SETTIMEOUT
> 4) Made WDIOC_GETTIMEOUT a "one shot"
> 5) Made printf of WDIOC_GETPRETIMEOUT disnct from WDIOC_SETPRETIMEOUT
> 6) Made WDIOC_GETPRETIMEOUT a "one shot"
> 
> Change v3
> 1) Printf says errno, but prints the string version of the error.
>    Make the printf consistent.
> 2) As above error was cut/paste from prior printf in application
>    add new patch 1 to fix the existing printf first.
> 
> Jerry Hoemann (2):
>   selftests: watchdog: Fix error message.
>   selftests: watchdog: Add gettimeout and get|set pretimeout
> 
>  tools/testing/selftests/watchdog/watchdog-test.c | 41 +++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 

Thanks for the patches. Applied to linux-kselftest next for 4.20-rc1

btw -for future reference, the convention is [PATCH v3] not [V3 PATCH]

thanks,
-- Shuah
