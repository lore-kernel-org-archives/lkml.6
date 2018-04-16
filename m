Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDPQ2t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:28:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbeDPQ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:28:47 -0400
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
To: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <53700469-74f0-f3b0-96a4-d8ace2919b36@redhat.com>
Date: Mon, 16 Apr 2018 18:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2018 00:26, KarimAllah Ahmed wrote:
> Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
> use the size of "requests" instead of the hard-coded '32'.
> 
> That gives us a bit more room again for arch-specific requests as we
> already ran out of space for x86 due to the hard-coded check.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

I'm afraid architectures like ARM 32 need this to be conditional (using
Kconfig).

Thanks,

Paolo

> ---
>  include/linux/kvm_host.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..fe4f46b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -129,7 +129,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQUEST_ARCH_BASE     8
>  
>  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
> -	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
> +	BUILD_BUG_ON((unsigned)(nr) >= (sizeof(((struct kvm_vcpu *)0)->requests) * 8) - KVM_REQUEST_ARCH_BASE); \
>  	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
>  })
>  #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
> @@ -223,7 +223,7 @@ struct kvm_vcpu {
>  	int vcpu_id;
>  	int srcu_idx;
>  	int mode;
> -	unsigned long requests;
> +	u64 requests;
>  	unsigned long guest_debug;
>  
>  	int pre_pcpu;
> @@ -1122,7 +1122,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
>  	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
>  	 */
>  	smp_wmb();
> -	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> +	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
>  }
>  
>  static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
> @@ -1132,12 +1132,12 @@ static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
>  
>  static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	return test_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> +	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
>  }
>  
>  static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	clear_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> +	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
>  }
>  
>  static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
> 
