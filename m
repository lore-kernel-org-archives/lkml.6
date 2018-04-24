Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49ukWSK7RjwtGGUlkcsFDerc1LXqiC+4SjGWqv4IUR5a60jcY5Pxom/jxvq8mwCOhoVfhCO
ARC-Seal: i=1; a=rsa-sha256; t=1524598561; cv=none;
        d=google.com; s=arc-20160816;
        b=EmBFJYxLH9fv1O3GGli/GladuIIyTo4B5NoTvSn7JMhsU7kNZNk7THALIHwdt/AM3w
         /4/QBQzF/C0o8MNVhap52LvybTHz56HgUfx/2aTfOrwoxigGvlPs48EruAqOJ9bUaLn6
         Ah9ezXoTKGMQFvAvLnlaDlAhM6jpoZHBENOZWKDynferbqujuao7UqtNdUwysTYQHRdr
         Fj5nIBBZFN+YJhcuPFe/Hj8JrhpI+mCKPRP1WZdKg9hJmc64JFzFO/o3A1q7IgGZprqh
         tTOcKQQBjD0JRztCQaX/wTVONJMg850dCKSzN1J4pdvWZ2YqfHxQ2lyRoffPLLezlhhZ
         yiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=5TWvJQnDEtzKZ3SE880ONllbN9gSP9lAqKMTfwQuTnk=;
        b=rOk/z0shCWk15WkFNIAC+pXmEqrAKenhLAsvTShWr/FIsSkV1CC8YjNAteV4NIsN4l
         liRJXRR8fLHU+u1Iah6KeLbXJh+Omb9i62oIwjNQpi8fNF9kgy0vSc+2SuUL/bWoQErz
         Mu0W5wG5uIKC2MEY9+G6Co2AGqZirkH/DbSrMkAwIANQUZd4O6EESWzZeYA3vpUTouIC
         20Gxahf/0PfttVYAFcdVjkI86HqrNvYWXrq1zEArBFb7nWN6YqTS72fzV/eT/5ZSmXG+
         VTeOrGgP4HA/cV/YUPzTX2wF6eLCt/Xnhn51+ak4AXsVVYJH6a3dP7BhBvez9hBHPPqW
         pWxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeDXTgA (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 15:36:00 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:55167 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeDXTf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 15:35:57 -0400
Subject: Re: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing new
 tests
To: Anders Roxell <anders.roxell@linaro.org>, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180417084631.11242-1-anders.roxell@linaro.org>
 <20180419102825.2990-1-anders.roxell@linaro.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d65f770f-e871-53e4-828f-4ba94df90ae3@kernel.org>
Date: Tue, 24 Apr 2018 13:35:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419102825.2990-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597982439415965732?=
X-GMAIL-MSGID: =?utf-8?q?1598657460935742014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/19/2018 04:28 AM, Anders Roxell wrote:
> Add a description that the kernel headers should be used as far as it is
> possible and then the system headers.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  Documentation/dev-tools/kselftest.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index e80850eefe13..3bf371a938d0 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -151,6 +151,11 @@ Contributing new tests (details)
>     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
>     test.
>  
> + * First use the headers inside the kernel source and/or git repo, and then the
> +   system headers.  Headers for the kernel release as opposed to headers
> +   installed by the distro on the system should be the primary focus to be able
> +   to find regressions.
> +
>  Test Harness
>  ============
>  
> 

Here is my reviewed by for this to go through documentation tree.

Reviewed-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah

