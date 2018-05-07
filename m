Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeEGLqY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:46:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751991AbeEGLqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:46:20 -0400
Subject: Re: [PATCH 14/24] selftests: kvm: return Kselftest Skip code for
 skipped tests
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>, hofsass@google.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-14-shuah@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <08ca6038-00a0-1526-493a-36e6732b5934@redhat.com>
Date: Mon, 7 May 2018 13:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180505011328.32078-14-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2018 03:13, Shuah Khan (Samsung OSG) wrote:
> When kvm test is skipped because of unmet dependencies and/or unsupported
> configuration, it exits with error which is treated as a fail by the
> Kselftest framework. This leads to false negative result even when the test
> could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to clearly
> report that the test could not be run.
> 
> Change it to use ksft_exit_skip() when the test is skipped. In addition,
> refine test_assert() message to include strerror() string and add explicit
> check for root user to clearly identofy non-root user skip case.

Root should not be needed.

Otherwise

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/kvm/lib/assert.c          | 10 ++++++++--
>  tools/testing/selftests/kvm/vmx_tsc_adjust_test.c |  4 +++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index c9f5b7d4ce38..4705729d847e 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -13,6 +13,8 @@
>  #include <execinfo.h>
>  #include <sys/syscall.h>
>  
> +#include "../../kselftest.h"
> +
>  /* Dumps the current stack trace to stderr. */
>  static void __attribute__((noinline)) test_dump_stack(void);
>  static void test_dump_stack(void)
> @@ -65,13 +67,17 @@ test_assert(bool exp, const char *exp_str,
>  {
>  	va_list ap;
>  
> +	if (getuid() != 0)
> +		ksft_exit_skip("Please run the test as root - Exiting.\n");

This should not be needed.  Otherwise
>  	if (!(exp)) {
>  		va_start(ap, fmt);
>  
>  		fprintf(stderr, "==== Test Assertion Failure ====\n"
>  			"  %s:%u: %s\n"
> -			"  pid=%d tid=%d\n",
> -			file, line, exp_str, getpid(), gettid());
> +			"  pid=%d tid=%d - %s\n",
> +			file, line, exp_str, getpid(), gettid(),
> +			strerror(errno));
>  		test_dump_stack();
>  		if (fmt) {
>  			fputs("  ", stderr);
> diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
> index 8f7f62093add..62fb73699eb6 100644
> --- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
> +++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
> @@ -28,6 +28,8 @@
>  #include <string.h>
>  #include <sys/ioctl.h>
>  
> +#include "../kselftest.h"
> +
>  #ifndef MSR_IA32_TSC_ADJUST
>  #define MSR_IA32_TSC_ADJUST 0x3b
>  #endif
> @@ -190,7 +192,7 @@ int main(int argc, char *argv[])
>  
>  	if (!(entry->ecx & CPUID_VMX)) {
>  		printf("nested VMX not enabled, skipping test");
> -		return 0;
> +		return KSFT_SKIP;
>  	}
>  
>  	vm = vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);
> 
