Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227D208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5227D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966005AbeFOQYn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:24:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43808 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964966AbeFOQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:24:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2E21241741;
        Fri, 15 Jun 2018 16:24:41 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9kzVaYgTBSTm; Fri, 15 Jun 2018 16:24:41 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id CDE4240D66;
        Fri, 15 Jun 2018 16:24:34 +0000 (UTC)
Subject: Re: [PATCH v2] selftests: sync: add config fragment for testing sync
 framework
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180614095708.27645-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <296328b2-73c7-c7c2-8416-7983438e8e62@kernel.org>
Date:   Fri, 15 Jun 2018 10:24:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614095708.27645-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 03:57 AM, Anders Roxell wrote:
> From: Fathi Boudra <fathi.boudra@linaro.org>
> 
> Unless the software synchronization objects (CONFIG_SW_SYNC) is enabled,
> the sync test will be skipped:
> 
> TAP version 13
> 1..0 # Skipped: Sync framework not supported by kernel
> 
> Add a config fragment file to be able to run "make kselftest-merge" to
> enable relevant configuration required in order to run the sync test.
> 
> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> Link: https://lkml.org/lkml/2017/5/5/14
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Thanks. Applied to linux-kselftest next for 4.18-rc2 fixes update

thanks,
-- Shuah
 

