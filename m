Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+LkX05RmKS1prf4uf3uixGVJtH5vqFE2V2uQkifgany7mIMx7O8qdXt1lFJBdKWQMbylpE
ARC-Seal: i=1; a=rsa-sha256; t=1523373643; cv=none;
        d=google.com; s=arc-20160816;
        b=JCjzLXHQi/W7fOn8pykVcf4eNJZW7IkmCsrFXibupUpCIXyEnwtSPUfILEWEEVWGSb
         byd79+pqhEMelZLi/nBMWtLY8yjywr3A7QevUQ0m74ZWNdfRyfHMG6hruQkVoJa6Wfiz
         wYdtnOHZKbV/3YreWu+HqH1j2HX3B6O2EhInOWUMV5sa2G60CqVQvhe5P07qxppIh7oL
         G9IPA+bUc/Qif5B1Ef6rKc3fb8olw8chvh37zOOgp8ZjtvqMjTK7Anq6maoauCAvmQSo
         nGBL9q346qoYtbWNDhKIz5Trr8DJ5f7MJtWFU8QUm2RWQhTTFyGRauKt0NC+pMMBpNI4
         VQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:autocrypt:openpgp:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=vpzFq0ciSXHT636qr31twdYYTpBrebgQ4GcQvcydKUg=;
        b=0xEr31tNglZZtka5bi4oDjuGKqnQYksCjuJpEjHYtmmDeuHRXYAWLOJkYtW1EOOHbn
         YGDcc5HYjYYY2DKptx45N+z6H0jpTcx9VLKHOiDcmz3tVG2vEPA/BbdHQf9QHGKX6TIQ
         RXVHfT2jwie4TR8cUmk7yqx8N4eB10LfqqNvMf8rxUmgl012lHmAijeb1t5LuM+cmfdW
         p4yV2a8DDCqY/rC7LNKSkQEi/Z8PdsK9urZ8eB/VnEIgXHKp7l2lWPbuFRsosDR6VNNo
         DGiD+02PCS7TqRvs8IdHSIA3t7ewYcwO6/ndSS2N2/BNyRx8qVXLTZFpe1+k3+eEQW34
         xIdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=W3N4x0i1;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=W3N4x0i1;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeDJPUl (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 11:20:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34203 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbeDJPUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 11:20:40 -0400
Subject: Re: [PATCH][next] kvm: selftests: fix spelling mistake: "divisable"
 and "divisible"
To: Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Ken Hofsass <hofsass@google.com>,
        linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180410123856.24869-1-colin.king@canonical.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <8a6e5200-15be-f5e6-d2a8-1ea03f653c54@redhat.com>
Date: Tue, 10 Apr 2018 17:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410123856.24869-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597362884933828919?=
X-GMAIL-MSGID: =?utf-8?q?1597373041126940181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/04/2018 14:38, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistakes in comment and message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c  | 2 +-
>  tools/testing/selftests/kvm/lib/sparsebit.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 7ca1bb40c498..e213d513dc61 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1435,7 +1435,7 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm,
>  	sparsebit_idx_t pg;
>  
>  	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> -		"not divisable by page size.\n"
> +		"not divisible by page size.\n"
>  		"  paddr_min: 0x%lx page_size: 0x%x",
>  		paddr_min, vm->page_size);
>  
> diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
> index 0c5cf3e0cb6f..b132bc95d183 100644
> --- a/tools/testing/selftests/kvm/lib/sparsebit.c
> +++ b/tools/testing/selftests/kvm/lib/sparsebit.c
> @@ -121,7 +121,7 @@
>   *     avoided by moving the setting of the nodes mask bits into
>   *     the previous nodes num_after setting.
>   *
> - *   + Node starting index is evenly divisable by the number of bits
> + *   + Node starting index is evenly divisible by the number of bits
>   *     within a nodes mask member.
>   *
>   *   + Nodes never represent a range of bits that wrap around the
> @@ -1741,7 +1741,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
>  
>  		/* Validate node index is divisible by the mask size */
>  		if (nodep->idx % MASK_BITS) {
> -			fprintf(stderr, "Node index not divisable by "
> +			fprintf(stderr, "Node index not divisible by "
>  				"mask size,\n"
>  				"  nodep: %p nodep->idx: 0x%lx "
>  				"MASK_BITS: %lu\n",
> 

Queued, thanks.

Paolo

