Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7D0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B342077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VudJtAVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B342077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKIBiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeKIBiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:38:46 -0500
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B42F2077B;
        Thu,  8 Nov 2018 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541692957;
        bh=APdS3ZrdHRwtHetW/ichDdeVYQzj5WC1wlqd8/10Yow=;
        h=To:Cc:From:Subject:Date:From;
        b=VudJtAVJyr5NFaXKjHq7nRHQWE6hzgVkvA4AkrhYWJnWDwoMPiCIS8vkUr+b95gtT
         5jhVM3tBK7M7Q/uuyL2hcvQOMUG1RkW+mrljKxLXeon7OKoun9X4sFzwtyf+Ky4Kfp
         s7daMirjPcVuZVkABXvMGHUN/R99F4C+0LB35ovA=
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Subject: [ANNOUNCEMENT] Kselftest wiki updated
Message-ID: <f261256f-0abd-5d72-597e-09f74fa4dea4@kernel.org>
Date:   Thu, 8 Nov 2018 09:02:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Updating Kselftest wiki and providing links to overview and how-to documents
has been on my list of things to do for a while.

It is now updated with the current status and links to documents. I am planning
to write a detailed how-to blog/article.

https://kselftest.wiki.kernel.org

thanks,
-- Shuah
