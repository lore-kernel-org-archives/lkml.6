Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuYs/aiBT06pbBQbruOd8PM7yTklPSH7XIPrKnhe9h+VD9SaE05du3fRt0QjBcyNRb+x+Uv
ARC-Seal: i=1; a=rsa-sha256; t=1521238791; cv=none;
        d=google.com; s=arc-20160816;
        b=ytE4UYhEahM3k49GQnbcnpnFdOU7j2yz1znJR+RWY5YkQlFJewQEOMlmbsAX5QsxPd
         z5/Ku6gNduahQlM1VGPFnBwg+rRR9T50a1/QKFUy8623HeddiLgXMfwcNE6SG4mrxlVs
         7eLcE4cnCfcPoT8uWfKuKz5wjnZlk9rODb45XaIXSZouylvfiFQbTkz+OAfc216OKd/i
         J5LyKlc4Q5WWNMBPq4i4ITtyIH7Lf+VU43H+GCwVODfPcMyJFwshuRO69UbGVa7AW9jE
         Zom/Nzvv7d4Mn7FyC/Gg2zyQZGnfbtlBrkZhfa8QdK1D/grm8aBjOapce2R8pag8kIhw
         8rkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=lZmtn+5jLJIJihqPTnzgA2yTPiVhAgF1rwrw4l7QcaY=;
        b=PU+tsxkqhX+l7EtTN13BJymzvvpPqEtscTjIHFIo1PNl7V3GTjxdyZPlgeGb81wLNn
         5Lh4C3n5KybKQUw4c7hYdlJBPFSk2wcPsVHt6FrLmzOFnboapUuNbcVZWl4/fV4nJe28
         flL0sbclF7AwUYHTSHxOvHjLh00tbwjj7QjZ+T1gk3X8KzrsDtbltwamz9mN4k4tXfWF
         rU8g953sapAdBMJxw/LfoCubZju5htfTpEFQRGTaXStU33g4cAxSi0sRDRyDY7TA9D50
         K1+SuQJ8Ip5jcJXTWwxCjbLDX/znVacJovclqpOy7Eo3tsC4w5BMIB1WtXEm4F6uTvhR
         1YAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeCPWTW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:19:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:54176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeCPWTV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:19:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25371125"
Subject: Re: [PATCH v12 11/22] selftests/vm: pkey register should match shadow
 pkey
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-12-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e9270064-4951-26dc-aeb0-1378fd7ab542@intel.com>
Date: Fri, 16 Mar 2018 15:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-12-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064626705149797?=
X-GMAIL-MSGID: =?utf-8?q?1595134487150749111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> expected_pkey_fault() is comparing the contents of pkey
> register with 0. This may not be true all the time. There
> could be bits set by default by the architecture
> which can never be changed. Hence compare the value against
> shadow pkey register, which is supposed to track the bits
> accurately all throughout
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 254b66d..6054093 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -926,10 +926,10 @@ void expected_pkey_fault(int pkey)
>  	pkey_assert(last_pkey_faults + 1 == pkey_faults);
>  	pkey_assert(last_si_pkey == pkey);
>  	/*
> -	 * The signal handler shold have cleared out PKEY register to let the
> +	 * The signal handler shold have cleared out pkey-register to let the

Heh, you randomly changed the formatting and didn't bother with my awful
typo. :)

>  	 * test program continue.  We now have to restore it.
>  	 */
> -	if (__rdpkey_reg() != 0)
> +	if (__rdpkey_reg() != shadow_pkey_reg)
>  		pkey_assert(0);
>  
>  	__wrpkey_reg(shadow_pkey_reg);
> 

I don't think this should be "shadow_pkey_reg".  This was just trying to
double-check that the signal handler messed around with PKRU the way we
expected.

We could also just check that the disable bits for 'pkey' are clear at
this point.  That would be almost as good.
