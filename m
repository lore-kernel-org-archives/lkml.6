Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41182C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43722088E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43722088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1ACT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:02:19 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48015 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH1ACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:02:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 5F826418F9;
        Mon, 27 Aug 2018 20:14:11 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B95-BdoWhs1A; Mon, 27 Aug 2018 20:14:11 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 34A0A40F97;
        Mon, 27 Aug 2018 20:14:06 +0000 (UTC)
Subject: Re: [PATCH] selftests: kselftest: Remove outdated comment
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180725025725.4214-1-bauerman@linux.ibm.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <99fd20f8-b3fd-c5b7-ccb2-092888c8545f@kernel.org>
Date:   Mon, 27 Aug 2018 14:14:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725025725.4214-1-bauerman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 08:57 PM, Thiago Jung Bauermann wrote:
> Commit 3c07aaef6598 ("selftests: kselftest: change KSFT_SKIP=4 instead of
> KSFT_PASS") reverted commit 11867a77eb85 ("selftests: kselftest framework:
> change skip exit code to 0") but missed removing the comment which that
> commit added, so do that now.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  tools/testing/selftests/kselftest.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 15e6b75fc3a5..a3edb2c8e43d 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -19,7 +19,6 @@
>  #define KSFT_FAIL  1
>  #define KSFT_XFAIL 2
>  #define KSFT_XPASS 3
> -/* Treat skip as pass */
>  #define KSFT_SKIP  4
>  
>  /* counters */
> 
> 

Thanks for the patch. Sorry for the delay. It is now in linux-kselfttest
next for the next 4.19-rc

thanks,
-- Shuah
