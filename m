Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-2167642-1520397833-2-15252092121877989562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.214.67', Host='mail-it0-f67.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520397832; b=kr+Shvqfogj1Fx2ZxHiWbFzXm8I9UeV7whRHNz6H52PnyYI
    kqpuw/EfzzDqF+MYM0wIWsIGNCOE1OxmKnP8GWmFVoYkcN+Eig+az5Oiu8SF6dGC
    yP9P57tfOebDvWUrN1h/4I8nvQJJrU1xmGBLDH4n/Da268qekGejLk4V9bgWUq8m
    +Www4revmnnliLnqMI64d5rwymGrzqZWPmvOn+08bB+wL4AeTaL33BYu7WogAPXT
    IJ6n8KkOP+QSR2CrO5SV4KkQ5GnNWbcBohRpBT7Zc1MiuLPUagCpCQ0I+ikeI0d8
    yRUJhIX+1ai8BowZ5KZN5Dl+cR//H32ozpqLw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1520397832; bh=LxnuEoG7
    qfia6jzDPYMfYBJf9tepHGgwNEGxrxJpd/A=; b=LsJTN9KldQeyyihPvoQ7o6cy
    0hSfWlVwoZ2C0v3DijEXKD7LpAiXAoPUSJxGXQCyfFD3ljvdsi+VdlJghbazYcLb
    5bHehvaCaX7O6lVRsGJ9ZxWO9ZsWJ0BV4XL7YYbttBw7/Bd3WdBFWyT2WoX2wooQ
    VmT8Smf+oQTk+12QP2g3H3HcDAKSeyqo6YYmA76l6lN4vnl2rM+tip/VFl+cNQLu
    78nKNGNmvgb7cXmogEi+Frv6DufY6qgBAUOCmOzi4nKufxzIKT9KUYVo4rrwlFMd
    iFbIsFmQ/X3NhGLn2ykxStkc7ooP0NaQKr+j0RHwh9EzKczQOXSzYHuiTn0eQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=deUStriJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.214.67 (mail-it0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-it0-f67.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XphS6jwb;
    x-ptr=pass x-ptr-helo=mail-it0-f67.google.com x-ptr-lookup=mail-it0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=deUStriJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.214.67 (mail-it0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-it0-f67.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XphS6jwb;
    x-ptr=pass x-ptr-helo=mail-it0-f67.google.com x-ptr-lookup=mail-it0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvnTqcMVP0ffGeZZYQVF3bJRVdRyIJtl2rlNSGeOVCpocyU5U+cGsFw3SkoFJtujbH44yOLbw==
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
To: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com> <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com> <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <f626d6a8-41c9-7481-e21c-7b8b8fe2e277@linaro.org>
Date: Wed, 7 Mar 2018 12:43:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306172525.GA6618@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/07/2018 01:25 AM, Greg KH wrote:
> I suggest looking at the backports in the android-common tree that are
> needed for this "feature" to work properly, and pull them out and test
> them if you really want it in your Linaro trees.  If you think some of
> them should be added to the LTS kernels, I'll be glad to consider them,
> but don't do a hack to try to work around the lack of these features,
> otherwise you will not be happy in the long-run.
> 

Thanks for response! :)

If we want the life easy for Linaro, we don't do backporting for LTS
first, that cause more trouble to skip features which are merged in our
tree already, like kaslr, software pan. Backporting to lts first make
double trick when merge it back. We did this just because, we believe
LTS need this.

And further more, android skip tooooo much fix patch for this 2 bugs:
some main commits are following:
for metldown:

arm64: kpti: Add ->enable callback to remap swapper using nG mappings
arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
arm64: Turn on KPTI only on CPUs that need it

For spectre, which is totally missing in android.

arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
arm/arm64: smccc: Make function identifiers an unsigned quantity
arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
arm/arm64: KVM: Turn kvm_psci_version into a static inline
arm64: KVM: Increment PC after handling an SMC trap
arm64: Implement branch predictor hardening for affected Cortex-A CPUs
arm64: entry: Apply BP hardening for suspicious interrupts from EL0
arm64: entry: Apply BP hardening for high-priority synchronous exceptions
arm64: KVM: Use per-CPU vector when BP hardening is enabled
arm64: Move BP hardening to check_and_switch_context
arm64: Add skeleton to harden the branch predictor against aliasing attacks
arm64: cpufeature: Pass capability structure to ->enable callback
arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
arm64: barrier: Add CSDB macros to control data-value prediction
arm64: alternatives: apply boot time fixups via the linear mapping

Thanks!
Alex
