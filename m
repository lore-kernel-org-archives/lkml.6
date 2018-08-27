Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1940FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E50208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E50208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeH0XZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:25:22 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34910 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeH0XZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:25:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 65C452187A;
        Mon, 27 Aug 2018 19:37:23 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9iKaE354JjFi; Mon, 27 Aug 2018 19:37:23 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 391EE20EAF;
        Mon, 27 Aug 2018 19:37:18 +0000 (UTC)
Subject: Re: [PATCH v2] selftests: android: move config up a level
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180824124941.10146-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4479e4c6-18a5-a60a-62d5-29a1c13d4650@kernel.org>
Date:   Mon, 27 Aug 2018 13:37:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824124941.10146-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:49 AM, Anders Roxell wrote:
> 'make kselftest-merge' assumes that the config files for the tests are
> located under the 'main' test dir, like tools/testing/selftests/android/
> and not in a subdir to android.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/android/{ion => }/config | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename tools/testing/selftests/android/{ion => }/config (100%)
> 
> diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/config
> similarity index 100%
> rename from tools/testing/selftests/android/ion/config
> rename to tools/testing/selftests/android/config
> 


Applied to linux-kselftest next for next 4.19-rc2

thanks,
-- Shuah
