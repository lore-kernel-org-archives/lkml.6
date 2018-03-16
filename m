Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu5JCoG/w228IF2BtN1AzvXWT1VRGwSYfA7eCIN8OCK2SX/zsBDDfd/5kxGfc6FFaBXiOa0
ARC-Seal: i=1; a=rsa-sha256; t=1521238956; cv=none;
        d=google.com; s=arc-20160816;
        b=Bf2pQimg/f/fiN4fvnOmhLxVe965DFFnG8HHQRl6t7CbDVLK50IbRG8NLdRLZZ4KhM
         DCn843UMCgldSbNUH5o0dFjKzIVu9Lwn3qqyGMSFLQypQxDF7tQ6Mnv8P7BtZR+VwQQi
         Gy9TGFqbo4xZ63cXdzK5S7muHAyOVi0RR8kUFb+OfSoZ2dI5vEXOGKTH4mJVV4WM4o/l
         kTPRI4e4+Ze3SJUGwsFZgOiHVY4yORF5WJ3vb6C0UjS5HkaLx61kyCccJ2MNIHDT83vM
         FqL9jnqM5GmnbT1x3Thv3JFqIWjrUgjbifYDU5N+BcTI+V0Yf9EGiZ/A/XNgLnPhr0G1
         3waA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=UtKHs38hFkY+Me0HwMeD0Qpv7+gy2W1Vl9f0Z8RvPOY=;
        b=wNP/EVFvRRbYSltFMcQoe430RPB0KLwYI/EI8JwWCvhayR4wFm4OuHji8PzWmD1sCO
         l4yK2lWP5KjmH0++6j+xjdg6VKGvGLznBTvms98hsiJKhi75Yl5Irb5vwu1Ew8mmil87
         LLaqI0hWTMU1dWIlY/eDf05mzf5j8edMdmAwsMQO78J1kj9oQHWz4gowwC6Gl9IECMYs
         hRxbvojhZs+X5UbzxWBL9HSWC/Qf8nMIwP/DtG+C8uBE7kXamWefHuxk36bIH0GC3wC5
         LpWII/wqtBmaH2mLdXBEwqrXARZNaNKQH/tvRu2Z7n/x1TLVSXN4XsXiq0zP9eHgBRqn
         OGZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeCPWWY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:22:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:51091 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbeCPWWX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:22:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25371741"
Subject: Re: [PATCH v12 12/22] selftests/vm: generic cleanup
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-13-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <920ff5c4-153a-488c-e502-82ea43adbd79@intel.com>
Date: Fri, 16 Mar 2018 15:22:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-13-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064411823518229?=
X-GMAIL-MSGID: =?utf-8?q?1595134660623071782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> cleanup the code to satisfy coding styles.
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |   81 ++++++++++++++------------
>  1 files changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 6054093..6fdd8f5 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -4,7 +4,7 @@
>   *
>   * There are examples in here of:
>   *  * how to set protection keys on memory
> - *  * how to set/clear bits in pkey registers (the rights register)
> + *  * how to set/clear bits in Protection Key registers (the rights register)

I don't think CodingStyle says to do this. :)

>   *  * how to handle SEGV_PKUERR signals and extract pkey-relevant
>   *    information from the siginfo
>   *
> @@ -13,13 +13,18 @@
>   *	prefault pages in at malloc, or not
>   *	protect MPX bounds tables with protection keys?
>   *	make sure VMA splitting/merging is working correctly
> - *	OOMs can destroy mm->mmap (see exit_mmap()), so make sure it is immune to pkeys
> - *	look for pkey "leaks" where it is still set on a VMA but "freed" back to the kernel
> - *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
> + *	OOMs can destroy mm->mmap (see exit_mmap()),
> + *			so make sure it is immune to pkeys
> + *	look for pkey "leaks" where it is still set on a VMA
> + *			 but "freed" back to the kernel
> + *	do a plain mprotect() to a mprotect_pkey() area and make
> + *			 sure the pkey sticks

Ram, I'm not sure where this came from, but this looks horrid.  Please
don't do this to the file

>   * Compile like this:
> - *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> - *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc      -o protection_keys    -O2 -g -std=gnu99
> + *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99
> + *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
>   */

Please just leave this, or remove it from the file.  It was a long line
so it could be copied and pasted, this ruins that.



>  #define _GNU_SOURCE
>  #include <errno.h>
> @@ -251,26 +256,11 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  	dprintf1("signal pkey_reg from  pkey_reg: %016lx\n", __rdpkey_reg());
>  	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
>  	*(u64 *)pkey_reg_ptr = 0x00000000;
> -	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
> +	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction "
> +			"to continue\n");
>  	pkey_faults++;
>  	dprintf1("<<<<==================================================\n");
>  	return;
> -	if (trapno == 14) {
> -		fprintf(stderr,
> -			"ERROR: In signal handler, page fault, trapno = %d, ip = %016lx\n",
> -			trapno, ip);
> -		fprintf(stderr, "si_addr %p\n", si->si_addr);
> -		fprintf(stderr, "REG_ERR: %lx\n",
> -				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
> -		exit(1);
> -	} else {
> -		fprintf(stderr, "unexpected trap %d! at 0x%lx\n", trapno, ip);
> -		fprintf(stderr, "si_addr %p\n", si->si_addr);
> -		fprintf(stderr, "REG_ERR: %lx\n",
> -				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
> -		exit(2);
> -	}
> -	dprint_in_signal = 0;
>  }

I think this is just randomly removing code now.

I think you should probably just drop this patch.  It's not really
brining anything useful.
