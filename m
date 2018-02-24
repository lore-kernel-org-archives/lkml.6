Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeBXAQu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:16:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752147AbeBXAQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:16:48 -0500
Subject: Re: [PATCH 0/4] KVM: SVM: kbuild test robot warning fixes
To: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
        Gary Hook <gary.hook@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180115133205.93859-1-brijesh.singh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4aca2e0-a931-75cd-abaf-95bf72ec35ca@redhat.com>
Date: Sat, 24 Feb 2018 01:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180115133205.93859-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2018 14:32, Brijesh Singh wrote:
> The patch series fixes the warnings reported by kbuild test robot
> after SEV patches. Additionally, during testing I found that LAUNCH_SECRET
> command was broken and patch series contains the fix for it.
> 
> The patch series applies on kvm/queue branch. 
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Gary Hook <gary.hook@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Brijesh Singh (4):
>   crypto: ccp: Fix sparse, use plain integer as NULL pointer
>   KVM: SVM: Fix sparse: incorrect type in argument 1 (different base
>     types)
>   include: psp-sev: Capitalize invalid length enum
>   KVM: SVM: Fix SEV LAUNCH_SECRET command
> 
>  arch/x86/kvm/svm.c           | 14 ++++++++++----
>  drivers/crypto/ccp/psp-dev.c |  8 ++++----
>  include/uapi/linux/psp-sev.h |  2 +-
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 

Applying patches 1 and 3 from this series, thanks.

Paolo
