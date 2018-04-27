Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZq/yQTl0WdmjVAvx9VARpxC7gb5HomrziWxx97mI4lICD4+ccykEo3Fi54bcfk+yhNuauuf
ARC-Seal: i=1; a=rsa-sha256; t=1524867236; cv=none;
        d=google.com; s=arc-20160816;
        b=ggDNsR+UK+1lHGA5uwsCQFQ9ycc59STM6duuS7DlrY0hnN6RQO2BtZFAbGQ4ie2XTf
         kc/NInk/tGGsEBkBfWCRMud7UOA/kwRFov1DVJVuimylWsvfx2gz5EUoYwmNyxia8geN
         IbLxJPfL7uZdCeGOZoeHF86gNu2tFePf/VvZiFAMvvJrWMfrwuwpm7bTBJkjGJqZ16l/
         pjBgpjU3nEzzkyKjgM0egX2E9GDa3zSmBQr/6XKcnEKA/gw4+natHu4dDiEkuc2GitML
         +CCmZ3sT4XTFg95Ul+rCK1n+tQ/LCCgc5yTwfQ5vIERUyz5c0OKmg3dZQGVnlctlAPi2
         ZwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:autocrypt:openpgp:from:references:cc:to:subject
         :arc-authentication-results;
        bh=76T+OXqCABoukcn/9i9+Gr5QGm8KuRZlLx3mrGMWIhI=;
        b=HO6+A6OatiEG5WEZTLhXGnqfAF7tCUDPOCqphDpgsF+xC05t3JKTjgRdQcWDoypgt6
         OKs4UBawyuctmqIi/uCW79AiWpgNtJod7+Uf0tnT9wKvWzOJSnguAx5rV16fWO/p4gHq
         BVdqyNtsvROXT2U4RPxFA7L67HJRf7/mA/Cdo936ZNL4jEM+MjIxv0PMx1e4SGYV9Rv0
         drNbBisS0rgVYiucutzZbWL2Le8uW+yCbSSGg0zR7F9Sbd2Yr0SO22PwmPfYALQl8HoR
         jLD1JZ4WsO+lq2lfbUyXMlgPkI5wrCyqNaPEF4zrRlF8H6K8fp6Dn/2af0c3JJI9AL5G
         JO6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759316AbeD0WNz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 18:13:55 -0400
Received: from osg.samsung.com ([64.30.133.232]:60458 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeD0WNy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 18:13:54 -0400
Subject: Re: [PATCH 4.17-rc2] selftests: Fix lib.mk run_tests target shell
 script
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180427215541.25007-1-mathieu.desnoyers@efficios.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f126217d-df7e-996f-e563-2cbc361e4137@osg.samsung.com>
Date: Fri, 27 Apr 2018 16:13:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427215541.25007-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598938049686929383?=
X-GMAIL-MSGID: =?utf-8?q?1598939187604260896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 03:55 PM, Mathieu Desnoyers wrote:
> Within run_tests target, the whole script needs to be executed within
> the same shell and not as separate subshells, so the initial test_num
> variable set to 0 is still present when executing "test_num=`echo
> $$test_num+1 | bc`;".
> 
> Demonstration of the issue (make run_tests):
> 
> TAP version 13
> (standard_in) 1: syntax error
> selftests: basic_test
> ========================================
> ok 1.. selftests: basic_test [PASS]
> (standard_in) 1: syntax error
> selftests: basic_percpu_ops_test
> ========================================
> ok 1.. selftests: basic_percpu_ops_test [PASS]
> (standard_in) 1: syntax error
> selftests: param_test
> ========================================
> ok 1.. selftests: param_test [PASS]
> 
> With fix applied:
> 
> TAP version 13
> selftests: basic_test
> ========================================
> ok 1..1 selftests: basic_test [PASS]
> selftests: basic_percpu_ops_test
> ========================================
> ok 1..2 selftests: basic_percpu_ops_test [PASS]
> selftests: param_test
> ========================================
> ok 1..3 selftests: param_test [PASS]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Fixes: 1f87c7c15d7 ("selftests: lib.mk: change RUN_TESTS to print messages in TAP13 format")
> CC: Shuah Khan <shuahkh@osg.samsung.com>
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/lib.mk | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 195e9d4739a9..c1b1a4dc6a96 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -20,10 +20,10 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>  
>  .ONESHELL:
>  define RUN_TESTS
> -	@export KSFT_TAP_LEVEL=`echo 1`;
> -	@test_num=`echo 0`;
> -	@echo "TAP version 13";
> -	@for TEST in $(1); do				\
> +	@export KSFT_TAP_LEVEL=`echo 1`;		\
> +	test_num=`echo 0`;				\
> +	echo "TAP version 13";				\
> +	for TEST in $(1); do				\
>  		BASENAME_TEST=`basename $$TEST`;	\
>  		test_num=`echo $$test_num+1 | bc`;	\
>  		echo "selftests: $$BASENAME_TEST";	\
> 

Great. Applied to linux-kselftest fixes for 4.17-rc4

thanks,
-- Shuah
