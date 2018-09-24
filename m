Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0876C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D7B2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D7B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeIYCBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:01:21 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56982 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYCBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:01:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 1EBA721EB6;
        Mon, 24 Sep 2018 19:57:30 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Skuor3mrPRL3; Mon, 24 Sep 2018 19:57:30 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 53428212D4;
        Mon, 24 Sep 2018 19:57:24 +0000 (UTC)
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <0a77c148-bb45-74c6-438e-2eef7a9b917b@kernel.org>
Date:   Mon, 24 Sep 2018 13:57:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 01:36 PM, Jerry Hoemann wrote:
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
> 
> Jerry Hoemann (1):
>   selftests: watchdog: Add gettimeout and get|set pretimeout
> 
>  tools/testing/selftests/watchdog/watchdog-test.c | 33 +++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 


You are a bit too quick with your v2 :) I am just about to respond to the v1. Please
look at my comments on v1. You will have to do another revision anyway to address
my comments.

thanks,
-- Shuah
