Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544711107;
	bh=vfOHb70GOidRcI8Dne8O2P6ASrrz7uigYJcPuqI8rFA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nfKn0Kk7n3u7DzuyfQ+Y8FtOHvkz5ezOVgnOaFSV9Rsn4a60GhBC9AdCMUE9fgGsy
	 i0focxWXM8PKHFiPBC6HEJiG64DloCEDEbbLPgu3Z2CzCtWcaMhybysPGKa/5D49ip
	 p9Skp+AmSI9MYy/Frxe/SkVILxf0Slbl2CE+hdew=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1619820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeLMOZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMOZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:25:06 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA23F20851;
        Thu, 13 Dec 2018 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544711105;
        bh=vfOHb70GOidRcI8Dne8O2P6ASrrz7uigYJcPuqI8rFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y5xk/w1ezH/m2lzjWjC5V1vWJvaN9fvDbxXrHoj9a/1O8cjIBIhcyr4QiTDPAyWXd
         rn/143xLm0DKyG2jh5CwLY9rWY344W/wBlALNairNNu1fgMVbB9u3jn6dEb3MnxrNO
         mADJPjNzxUjZWNvxhVIFBzb4SFi/VmR9ESNkl//Y=
Subject: Re: [PATCH][next] selftests: watchdog: fix spelling mistake
 "experies" -> "expires"
To:     Colin King <colin.king@canonical.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20181213094015.31397-1-colin.king@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <32532eac-969a-83e2-4373-fdbef613ce33@kernel.org>
Date:   Thu, 13 Dec 2018 07:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213094015.31397-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 2:40 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the --gettimeleft help text, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index dac907a932ce..c2333c78cf04 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -78,7 +78,7 @@ static void usage(char *progname)
>   	printf(" -T, --gettimeout    Get the timeout\n");
>   	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
>   	printf(" -N, --getpretimeout Get the pretimeout\n");
> -	printf(" -L, --gettimeleft   Get the time left until timer experies\n");
> +	printf(" -L, --gettimeleft   Get the time left until timer expires\n");
>   	printf("\n");
>   	printf("Parameters are parsed left-to-right in real-time.\n");
>   	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> 

That is quick! Thanks for the patch. I will apply it to linuxk-kselftest 
next

thanks,
-- Shuah
