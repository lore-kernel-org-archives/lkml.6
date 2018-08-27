Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CC0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24179208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24179208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH0Vpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:45:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:41804 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0Vpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:45:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C3DE541908;
        Mon, 27 Aug 2018 17:58:06 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id os65Ll5CQ-AB; Mon, 27 Aug 2018 17:58:06 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id C7F36418FC;
        Mon, 27 Aug 2018 17:57:59 +0000 (UTC)
Subject: Re: [PATCH] doc: dev-tools: kselftest.rst: update config file
 location
To:     Anders Roxell <anders.roxell@linaro.org>, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180824124744.9842-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <55c84596-0e12-0211-dbee-9eddb9a0ab28@kernel.org>
Date:   Mon, 27 Aug 2018 11:57:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824124744.9842-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:47 AM, Anders Roxell wrote:
> Config fragment files should be placed in
> tools/testing/selftests/<testdir>/config
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  Documentation/dev-tools/kselftest.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 6f653acea248..dad1bb8711e2 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -159,7 +159,7 @@ Contributing new tests (details)
>   * If a test needs specific kernel config options enabled, add a config file in
>     the test directory to enable them.
>  
> -   e.g: tools/testing/selftests/android/ion/config
> +   e.g: tools/testing/selftests/android/config
>  
>  Test Harness
>  ============
> 

Jo Jon,

This patch looks good. Here is my Ack for it go through doc tree.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah
