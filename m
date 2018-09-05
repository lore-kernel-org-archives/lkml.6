Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B19C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297932077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297932077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEV2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:28:01 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:49999 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 03EE4C08BD;
        Wed,  5 Sep 2018 16:56:58 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PRQGJcXaRYKU; Wed,  5 Sep 2018 16:56:57 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 3A7B5C1181;
        Wed,  5 Sep 2018 16:56:37 +0000 (UTC)
Subject: Re: [PATCH] selftests/efivarfs: add required kernel configs
To:     Lei Yang <Lei.Yang@windriver.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536117289-15240-1-git-send-email-Lei.Yang@windriver.com>
Cc:     Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <af970d74-8e88-341b-b703-bed94f0746bc@kernel.org>
Date:   Wed, 5 Sep 2018 10:56:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536117289-15240-1-git-send-email-Lei.Yang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 09:14 PM, Lei Yang wrote:
> add config file
> 
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  tools/testing/selftests/efivarfs/config | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/efivarfs/config
> 
> diff --git a/tools/testing/selftests/efivarfs/config b/tools/testing/selftests/efivarfs/config
> new file mode 100644
> index 0000000..4e151f1
> --- /dev/null
> +++ b/tools/testing/selftests/efivarfs/config
> @@ -0,0 +1 @@
> +CONFIG_EFIVAR_FS=y
> 


Thanks. Applied to linux-kselftest next,

-- Shuah
