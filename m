Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+xOotBeVA3m3svS0Ud1d0B0qqNZPO94jb9wGXxS9g/tf6SBbVJHXPIhWi+6pU+OaAX5apB
ARC-Seal: i=1; a=rsa-sha256; t=1524519377; cv=none;
        d=google.com; s=arc-20160816;
        b=lqXrq9b9uy1Z1QPdy2C91IeqZpVTPerC7kLnm9mV342mfAGBIOOfwH0XxKsQGRjCIc
         r0UpVTgwGmcJ2nCcEsu0cd8t6cQsdErwxYuYTEYgWYQe4c2HX4hpSA2IHVKncaDFKbue
         gXDw4W1Hinc7Alz142RJRQ66SxGr5MKgm1IZiltEDcWaXHnA/b2gftaCAAUwvDjPb52F
         u1Dy7dyogpCfxn5dG4dfmD0M12AWgzlSdPVKPgTjnXzF+HfxM17q+PHXQURne1LbZ77k
         kS1rUu8O4WO3XZt8BStjLh2rU5IldAr1KU4XmVEweLPIprYC+n8yBgGvXhzaO3rMPBHU
         twcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=AL2OWteZDojEEnFC38LnNvG9xNgyXKcSvjfP8JE8y1s=;
        b=cyPvZ3Rt8w9ITKYnmNGrW4w0MBfAGYn+CFGwVGsjQw8g8HAskhyQB+0ndWJl20SgQu
         x3uk8N7VVhgHGtuHw1eAMauNAr49kktr2lLcmTWo+iBvDqAgr1BHZXqchHgH1PNJ1Ebb
         HwPDQ+3gpch/tHxu4x0yvBxMP0UIpa98jrJE/tcg3h4TZyGXDZpSKe77xP/YBi4p+9Be
         Gs5UP/MNO2KZ2JLsRy9wC/9iOdrw0/v/CBiYvurCBJl783j7X15p4W+ITC40GMnYt/+u
         2BLE6H9v04V1l57D3wTc5/p1Z/peopbcIkOndmUPKR5IeRqVFmBN/YbutReWxp82Z1Sm
         0ZLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeDWVen (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 17:34:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:44957 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbeDWVem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 17:34:42 -0400
Subject: Re: [PATCH] selftests: bpf: update .gitignore with missing file
To: Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20180423135057.951-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ea150a6-8af1-3aa8-7ff0-5fdb64054bab@iogearbox.net>
Date: Mon, 23 Apr 2018 23:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180423135057.951-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598574430800162453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 03:50 PM, Anders Roxell wrote:
> Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 5e1ab2f0eb79..3e3b3ced3f7c 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -15,3 +15,4 @@ test_libbpf_open
>  test_sock
>  test_sock_addr
>  urandom_read
> +test_btf

Against which tree is this? This doesn't apply to bpf-next. It would
apply against bpf tree, but c0fa1b6c3efc ("bpf: btf: Add BTF tests")
is part of bpf-next, so fits to neither of them.
