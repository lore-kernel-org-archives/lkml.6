Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225MbDNwE+d8CRSSzpQLUdqq+opjZfvudRruIR9gatcjz6Hp8KXSN7pBA6QyX3M/+Ar8ZnJh
ARC-Seal: i=1; a=rsa-sha256; t=1519249053; cv=none;
        d=google.com; s=arc-20160816;
        b=0+GI/0bI7Ay2DZrVVI8DytYZ4JSWf2H3hZeBliSGGQf+I5A9jfc8W358RSK+oOhshk
         s2K/YoSaJ9tilBlvCuqbn09q5TeLYA4wSUAGPcyvMsUvhov0EIBvQidit8u3NCZYUGOT
         hZJsFHcsPWzRCWbeecxM92WLElI9woEL6o506n3WPUhBH/uyHbeBuj3RCJyjh+hRclu4
         Aw0IOrZOfPGdQbitq6ve7sSvpaPzTcSWvU94yQbhsL+uCucs4pccR3d15B2IM7c5ikDh
         xBEjMZkRmHqgVd48cmjgSPa5VFEd1i3gr9X73YNNrtplkuivADJdDo/Mzw7yDqC8H8wU
         peSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=ZfLsxFKPw8IWB0SHtqJduImOx8xD60tUgcPWD1LfJIg=;
        b=eGWQdoqImIUOFhkxvNMdNU7aUi0NyYYbWRuxt8C/A6l7ujQzUvmFsktgASuVC0+aqS
         ekrPx4aNS2vF5cyoFtsqTjcDYKrwBfrnCoJRkzgqSGWDOnG1OPdqB0C0psdgilvkHyaX
         p2dh/7Fq+Xc1UmBfLbQnDda2IX2KMQl7VKhhu494FBjykuGeVSjx69p8kT/AdJikrTR6
         52YvtC6OM1i7+y7z5wzYdWTl7NqPWCTGvlbTSxvnhC8SGfg6QyqmU45ZIkrUF6b8hHIJ
         0x9AiMS/EWhvmPC0UTfp+9KdroXNwnEEWGLbCVYY3IRAxVAoI7DCcvhjeOPmOlFhPz+9
         4qQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=fT1ga+A5;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=fT1ga+A5;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBUVhR (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 16:37:17 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41862 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeBUVhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 16:37:16 -0500
Subject: Re: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20180221213001.18682-1-anders.roxell@linaro.org>
From: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <537755db-cf7b-950d-6f30-871b3b412411@linaro.org>
Date: Wed, 21 Feb 2018 15:37:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221213001.18682-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593048095947583312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 03:30 PM, Anders Roxell wrote:
> bpf builds a test program for loading BPF ELF files. Add the executable
> to the .gitignore list.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Tested-by: Daniel Díaz <daniel.diaz@linaro.org>

> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index cc15af2e54fe..9cf83f895d98 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -11,3 +11,4 @@ test_progs
>  test_tcpbpf_user
>  test_verifier_log
>  feature
> +test_libbpf_open
