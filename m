Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB8D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB8D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeGSNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:53:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbeGSNxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC824AE69;
        Thu, 19 Jul 2018 13:10:33 +0000 (UTC)
Subject: Re: [PATCH v1] lib: Remove 'default n' in Kconfig for tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20180719085131.79541-1-andriy.shevchenko@linux.intel.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2731955a-eae5-38f2-c815-713093b11909@suse.de>
Date:   Thu, 19 Jul 2018 21:10:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719085131.79541-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/19 4:51 PM, Andy Shevchenko wrote:
> It seems contributors follow the style of Kconfig entries where explicit
> 'default n' is present. The default 'default' is 'n' already, thus, drop
> these lines from Kconfig to make it more clear.
> 
> Cc: Coly Li <colyli@suse.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  lib/Kconfig       |  1 -
>  lib/Kconfig.debug | 17 -----------------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 031655d26dce..40bfa6ccd294 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -231,7 +231,6 @@ config AUDIT_COMPAT_GENERIC
>  
>  config RANDOM32_SELFTEST
>  	bool "PRNG perform self test on init"
> -	default n
>  	help
>  	  This option enables the 32 bit PRNG library functions to perform a
>  	  self test on initialization.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c731ff97500c..244c08055d8e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1225,7 +1225,6 @@ config LOCK_TORTURE_TEST
>  	tristate "torture tests for locking"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> -	default n
>  	help
>  	  This option provides a kernel module that runs torture tests
>  	  on kernel locking primitives.  The kernel module may be built
> @@ -1692,7 +1691,6 @@ config LKDTM
>  	tristate "Linux Kernel Dump Test Tool Module"
>  	depends on DEBUG_FS
>  	depends on BLOCK
> -	default n
>  	help
>  	This module enables testing of the different dumping mechanisms by
>  	inducing system failures at predefined crash points.
> @@ -1726,7 +1724,6 @@ config KPROBES_SANITY_TEST
>  	bool "Kprobes sanity tests"
>  	depends on DEBUG_KERNEL
>  	depends on KPROBES
> -	default n
>  	help
>  	  This option provides for testing basic kprobes functionality on
>  	  boot. Samples of kprobe and kretprobe are inserted and
> @@ -1737,7 +1734,6 @@ config KPROBES_SANITY_TEST
>  config BACKTRACE_SELF_TEST
>  	tristate "Self test for the backtrace code"
>  	depends on DEBUG_KERNEL
> -	default n
>  	help
>  	  This option provides a kernel module that can be used to test
>  	  the kernel stack backtrace code. This option is not useful
> @@ -1807,7 +1803,6 @@ config TEST_PRINTF
>  
>  config TEST_BITMAP
>  	tristate "Test bitmap_*() family of functions at runtime"
> -	default n
>  	help
>  	  Enable this option to test the bitmap functions at boot.
>  
> @@ -1831,7 +1826,6 @@ config TEST_OVERFLOW
>  
>  config TEST_RHASHTABLE
>  	tristate "Perform selftest on resizable hash table"
> -	default n
>  	help
>  	  Enable this option to test the rhashtable functions at boot.
>  
> @@ -1839,7 +1833,6 @@ config TEST_RHASHTABLE
>  
>  config TEST_HASH
>  	tristate "Perform selftest on hash functions"
> -	default n
>  	help
>  	  Enable this option to test the kernel's integer (<linux/hash.h>),
>  	  string (<linux/stringhash.h>), and siphash (<linux/siphash.h>)
> @@ -1853,7 +1846,6 @@ config TEST_IDA
>  
>  config TEST_PARMAN
>  	tristate "Perform selftest on priority array manager"
> -	default n
>  	depends on PARMAN
>  	help
>  	  Enable this option to test priority array manager on boot
> @@ -1863,7 +1855,6 @@ config TEST_PARMAN
>  
>  config TEST_LKM
>  	tristate "Test module loading with 'hello world' module"
> -	default n
>  	depends on m
>  	help
>  	  This builds the "test_module" module that emits "Hello, world"
> @@ -1877,7 +1868,6 @@ config TEST_LKM
>  
>  config TEST_USER_COPY
>  	tristate "Test user/kernel boundary protections"
> -	default n
>  	depends on m
>  	help
>  	  This builds the "test_user_copy" module that runs sanity checks
> @@ -1890,7 +1880,6 @@ config TEST_USER_COPY
>  
>  config TEST_BPF
>  	tristate "Test BPF filter functionality"
> -	default n
>  	depends on m && NET
>  	help
>  	  This builds the "test_bpf" module that runs various test vectors
> @@ -1904,7 +1893,6 @@ config TEST_BPF
>  
>  config FIND_BIT_BENCHMARK
>  	tristate "Test find_bit functions"
> -	default n
>  	help
>  	  This builds the "test_find_bit" module that measure find_*_bit()
>  	  functions performance.
> @@ -1913,7 +1901,6 @@ config FIND_BIT_BENCHMARK
>  
>  config TEST_FIRMWARE
>  	tristate "Test firmware loading via userspace interface"
> -	default n
>  	depends on FW_LOADER
>  	help
>  	  This builds the "test_firmware" module that creates a userspace
> @@ -1926,7 +1913,6 @@ config TEST_FIRMWARE
>  
>  config TEST_SYSCTL
>  	tristate "sysctl test driver"
> -	default n
>  	depends on PROC_SYSCTL
>  	help
>  	  This builds the "test_sysctl" module. This driver enables to test the
> @@ -1937,7 +1923,6 @@ config TEST_SYSCTL
>  
>  config TEST_UDELAY
>  	tristate "udelay test driver"
> -	default n
>  	help
>  	  This builds the "udelay_test" module that helps to make sure
>  	  that udelay() is working properly.
> @@ -1946,7 +1931,6 @@ config TEST_UDELAY
>  
>  config TEST_STATIC_KEYS
>  	tristate "Test static keys"
> -	default n
>  	depends on m
>  	help
>  	  Test the static key interfaces.
> @@ -1955,7 +1939,6 @@ config TEST_STATIC_KEYS
>  
>  config TEST_KMOD
>  	tristate "kmod stress tester"
> -	default n
>  	depends on m
>  	depends on BLOCK && (64BIT || LBDAF)	  # for XFS, BTRFS
>  	depends on NETDEVICES && NET_CORE && INET # for TUN
> 

