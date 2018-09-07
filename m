Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4C8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CCE20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CCE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIHDgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:36:33 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37876 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:36:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3D949C1218;
        Fri,  7 Sep 2018 22:53:21 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lGmfq0RPTEnM; Fri,  7 Sep 2018 22:53:21 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 1719FC11FC;
        Fri,  7 Sep 2018 22:53:07 +0000 (UTC)
Subject: Re: kselftests for memory.oom.group
To:     jgkamat@fb.com
Cc:     linux-kselftest@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, jaygkamat@gmail.com,
        Shuah Khan <shuah@kernel.org>
References: <20180907164924.13789-1-jgkamat@fb.com>
 <20180907213405.31574-1-jgkamat@fb.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <6d514fa2-4f85-059b-8737-2cd03519156d@kernel.org>
Date:   Fri, 7 Sep 2018 16:53:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907213405.31574-1-jgkamat@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 03:34 PM, jgkamat@fb.com wrote:
> Here is the third version of the patchset.
> 
> Changes since the last patchset:
> - Updated commit message of first patch to clarify fixes
> - Add ack from Roman
> 
> There should be no code changes since the last patchset.
> 
> Let me know if any improvements can be made, and thanks for your time!
> -Jay
> 
> 

Hi Jay,

Thanks for these patches. Applied to linux-kselftest next

-- Shuah
