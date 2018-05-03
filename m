Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3287437-1525388639-2-2941273486668532546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525388639; b=ao9+oRlr9ligRypYAwfefDH9ydj/74KDBynVQXBoDJuSuurlpt
    VdLVwYTS83ST8yLXNP9NYN2he00H5BG8PBfz6UMv8I4i5mtXBzmHgpjIk5o/OfVy
    mDCdZORzpvCSU6LhjzwchTqAtwptQJoRpNGw+F8NQRFNisHRpKcuJ91FsvPayOFu
    xGaxXx0G1ksa+uJ3jh5DDYxj98J2FtB343Kejcz1kgr7ZJSrJKCsm2SWKSVHtCfc
    wLawjLGptwXybKBrj/rD3LM/Epxr18gq9HU+mwqOcMkPGrq/KFxIVFZffqyLyNpP
    kUueTAp7ct9RsCpy3QMHbGc4A+98yUv5ApCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1525388639; bh=KK5c7a5nEMGsC/S
    ovq+1DsJgOAZyupzH5jsDrjle6aM=; b=FzAxC/qTNhQPNzL9yYfXOO8pos66Ua0
    vf+vLr2hrVU0dK6VWQiNm9l7hZoH0V/b1mx8GPFLnlkRgeAa5m/2xCbstLsuBHiw
    vIhY6kImZ8YNLQXt/P5qiAMic2cz7olQi+044NnlV4VcuCeFomkPn+qhB8PMQKr6
    qhpWyfXxTnaobIrVHvcrxl+vJpGcI/vLgJDRrurYdtF1X+Ng7saxs/RVlQOEqc2z
    9+X/gypABgX57eVHOQqy1V39x3n3SUdx63eiMZyALS7X/7PTQnxehhzOOtB717Ag
    cYl6wz5vrYkr9Xd3m8XN3Fv9IPb+/Mju3TVHGnCfWgHllv83Czt0Z2w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGYuNJduYugQvRd8IgaRhgm2J9M67+4ESprOlN3c/JlPZkqQL2t1lD8B152ARGhL7CXgnPaLk8QYn3xjgB7L3162e4nJ6dl0cd3n70ZMax8HDd2faVps
    fm3ye/BpghcTWza/xQNhyx8bPkMtfDBFU1NbVUOMaVwjzHJAfiR63f0L1U1z6PnhiIAdzBZs2VogN7wAEdmQQFT1DIuOv8xiL+hiJef5l0BWHptrQX2GQjX3
    TGF8GZGt/BBqF164vbNj5Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=OGVS8ExFRShZt5WCF1sA:9
    a=MNuQNucFchy3HlxN:21 a=KzeqE_IMIRNNxLQK:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeECXD5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 3 May 2018 19:03:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59403 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECXD4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 19:03:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <87r2mso5up.fsf@xmission.com>
        <1525383075.3539.67.camel@linux.vnet.ibm.com>
        <87d0yco1vy.fsf@xmission.com>
        <1525384675.3539.89.camel@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 18:03:47 -0500
In-Reply-To: <1525384675.3539.89.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Thu, 03 May 2018 17:57:55 -0400")
Message-ID: <87fu38jq98.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fENGU-00076t-Dn;;;mid=<87fu38jq98.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+P25tpP9YJLDTEGMrKaV2jYisUSJQYpKI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 313 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.7%), b_tie_ro: 1.57 (0.5%), parse: 1.24 (0.4%),
        extract_message_metadata: 6 (2.0%), get_uri_detail_list: 3.5 (1.1%),
        tests_pri_-1000: 5 (1.7%), tests_pri_-950: 1.56 (0.5%), tests_pri_-900: 1.30
        (0.4%), tests_pri_-400: 34 (10.9%), check_bayes: 33 (10.5%), b_tokenize: 14
        (4.6%), b_tok_get_all: 9 (2.7%), b_comp_prob: 4.2 (1.3%), b_tok_touch_all:
        3.7 (1.2%), b_finish: 0.61 (0.2%), tests_pri_0: 246 (78.5%),
        check_dkim_signature: 0.78 (0.2%), check_dkim_adsp: 3.1 (1.0%),
        tests_pri_500: 3.8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Thu, 2018-05-03 at 16:38 -0500, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > [Cc'ing Kees and kernel-hardening]
>> >
>> > On Thu, 2018-05-03 at 15:13 -0500, Eric W. Biederman wrote:
>> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> >> 
>> >> > In environments that require the kexec kernel image to be signed, prevent
>> >> > using the kexec_load syscall.  In order for LSMs and IMA to differentiate
>> >> > between kexec_load and kexec_file_load syscalls, this patch set adds a
>> >> > call to security_kernel_read_file() in kexec_load_check().
>> >> 
>> >> Having thought about it some more this justification for these changes
>> >> does not work.  The functionality of kexec_load is already root-only.
>> >> So in environments that require the kernel image to be signed just don't
>> >> use kexec_load.  Possibly even compile kexec_load out to save space
>> >> because you will never need it.  You don't need a new security hook to
>> >> do any of that.  Userspace is a very fine mechanism for being the
>> >> instrument of policy.
>> >
>> > True, for those building their own kernel, they can disable the old
>> > syscalls.  The concern is not for those building their own kernels,
>> > but for those using stock kernels.  
>> >
>> > By adding an LSM hook here in the kexec_load syscall, as opposed to an
>> > IMA specific hook, other LSMs can piggy back on top of it.  Currently,
>> > both load_pin and SELinux are gating the kernel module syscalls based
>> > on security_kernel_read_file.
>> >
>> > If there was a similar option for the kernel image, I'm pretty sure
>> > other LSMs would use it.
>> >
>> > From an IMA perspective, there needs to be some method for only
>> > allowing signed code to be loaded, executed, etc. - kernel modules,
>> > kernel image/initramfs, firmware, policies.
>> 
>> What is the IMA perspective.  Why can't IMA trust appropriately
>> authorized userspace?
>
> Suppose a system owner wants to define a system wide policy that
> requires all code be signed - kernel modules, firmware, kexec image &
> initramfs, executables, mmapped files, etc - without having to rebuild
> the kernel.  Without a call in kexec_load that isn't possible.

Of course it is.  You just make it a requirement that before an
executable will be signed it will be audited to see that it doesn't
call sys_kexec_load.  Signing presumably means something.  So it should
not be hard to enforce a policy like that on a specialty system call
that most applications will never call.

>> >> If you don't trust userspace that needs to be spelled out very clearly.
>> >> You need to talk about what your threat models are.
>> >> 
>> >> If the only justification is so that that we can't boot windows if
>> >> someone hacks into userspace it has my nack because that is another kind
>> >> of complete non-sense.
>> >
>> > The usecase is the ability to gate the kexec_load usage in stock
>> > kernels.
>> 
>> But kexec_load is already gated.  It requires CAP_SYS_BOOT.
>
> It isn't a matter of kexec_load already being gated, but of wanting a
> single place for defining a system wide policy, as described above.

Signing is only a tool to enforce a policy.  Signing by itself is not a
policy.  Enforcing any quality controls in the signed executables should
trivially prevent kexec_load from being used.

Eric
