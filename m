Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+vqLhTjH7smWeogkHYTSsnXjV4QeRyxhZulNQnuKl3jm1B/FIhCKR5xLQXrkhIyap1N+fM
ARC-Seal: i=1; a=rsa-sha256; t=1524062970; cv=none;
        d=google.com; s=arc-20160816;
        b=T7c8xrU3z+2Aib5oZQQRkA+lxfzpttY9T7eX/N5uuVI02W1tbTeHvqcxAHJXwBXGud
         SuiTvkihEVbbQ2HbCBCHYwBQD0gs80YvS8+laQBN/oR7/tMYtQof2JAwtjx0PqoDxJRV
         Tf4pwbV/aFW9lPXdrMZHiFbLzCggU1svKT4tBM9W8BWpXP5puOkthvyxiLwq6y5PuRJ0
         uugfRQ5vp8S2WZ7NENkFJu3D55TPKDOgSaDFRECT5my7b3zn2HkW0NoXYd9IGVJZB0u6
         MGupwgwGBBuN68VFQNyKYKP05R2yKcaittFHtpReQubXQS/CMtDNgAicFoWEMvTvesGP
         6ZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=QIl9SWkrYvTS9ZQqWpmpaf0mr/Uv/E/ULjswv+9N9Zo=;
        b=Z4WfwgbvQLGvFPlq2ksuMlwuYw44NhsDMd8o5rgYfouo0Qf1iXJRCYTB5I6mupvT1G
         nCau1bmk0Ln0comvLr5WON/yDpEQnxDyplqZhiy/NqQmIZ0r/IdPTrG6G/5Q03cQAFat
         NY8ZXPNJUuw2YVo5UP4Yn6fC0xq7v5LzQu0DEIdnfG/iSy3ysRM4o+cvSyvt6KJ6FVHX
         TTvQQ5N7ExSjHxkUGbr5PJcYozeF+wHLAQFTP5CkhOeStXkZp9q5iXIWHcrkhLDCqdli
         L/b0MuoZ5n7ihGhqeHmrUQDr4Oo5IyB2LOW/iOHh14xXSXA8bEsOmxhJTmSMeqanOzLC
         BKgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeDROt3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 18 Apr 2018 10:49:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37448 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeDROt2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Apr 2018 10:49:28 -0400
Subject: Re: [PATCH] doc: dev-tools: kselftest.rst: update contributing new
 tests
To: Anders Roxell <anders.roxell@linaro.org>, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180417084631.11242-1-anders.roxell@linaro.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <cbea46f8-7d30-8298-b830-c6f2a4453101@kernel.org>
Date: Wed, 18 Apr 2018 08:48:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417084631.11242-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597982439415965732?=
X-GMAIL-MSGID: =?utf-8?q?1598095853736786816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 02:46 AM, Anders Roxell wrote:
> Add a description that the kernel headers should be used as far as it is
> possible and then the system headers.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  Documentation/dev-tools/kselftest.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index e80850eefe13..27f08d6ba91c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -151,6 +151,9 @@ Contributing new tests (details)
>     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
>     test.
>  
> + * First use the headers inside the kernel, and then the system headers. The
> +   internal headers should be the primary focus to be able to find regressions.

Clarifying the location of the headers might be helpful. This description uses
different terminology to describe kernel headers.

"First use the headers inside the kernel sources and/or git reo" would make this
clear. Instead of "internal headers" headers for the kernel release as opposed
to headers installed by the distro on the system would make a clear distinction.

thanks,
-- Shuah
