Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B18C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510827EC6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6510827EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936570AbeF2N3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:29:36 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43997 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935010AbeF2N3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:29:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 9C629C06C3;
        Fri, 29 Jun 2018 13:29:31 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s21Cofq4v3TH; Fri, 29 Jun 2018 13:29:31 +0000 (UTC)
Received: from [172.20.4.200] (unknown [50.236.218.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 24FFDC0587;
        Fri, 29 Jun 2018 13:29:22 +0000 (UTC)
Subject: Re: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing new
 tests
To:     Anders Roxell <anders.roxell@linaro.org>, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180629100248.11560-1-anders.roxell@linaro.org>
 <20180629125201.24025-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4b826a04-63a7-ceb9-af8d-a83e2248a4bb@kernel.org>
Date:   Fri, 29 Jun 2018 07:29:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629125201.24025-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 06:52 AM, Anders Roxell wrote:
> Add a description that kernel config options should be added into a
> config file that is placed next to the newly added test.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  Documentation/dev-tools/kselftest.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 3bf371a938d0..6f653acea248 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -156,6 +156,11 @@ Contributing new tests (details)
>     installed by the distro on the system should be the primary focus to be able
>     to find regressions.
>  
> + * If a test needs specific kernel config options enabled, add a config file in
> +   the test directory to enable them.
> +
> +   e.g: tools/testing/selftests/android/ion/config
> +
>  Test Harness
>  ============
>  
>
Thanks. Looks good to me.

Reviewed-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>


thanks,
-- Shuah


