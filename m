Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525384749-2-4612492371728443224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525384749; b=Pgm5Ps1wdCdb9sPXvY3FCzNXYr+W+dh74nxGPlnxavkvbie++1
    N4HKBoCAnmuXHypeDIwjnLcluhHRHnxm8EAH9cRuwzAwTgoFN2N6umI29tgymKWO
    likXTc70HXdYEi8wWy6X1PjIiPeHtpsLTAm2CaT1buJe+I1hy79bb+jwN1h/6vhD
    9pT8JmGCSqlxuW1Jz/YlGL9JEjj/uU1ksvDrooEaXDF6+xjmve6QAA/DPEvliv7i
    mc4rCliTgmDomTBzyXBAgOFzy8y4J6TbV/h3jPa3C8oaCbDFMu2t5n9F+YVzo5UY
    WMSmZTdJRrRnbnwYpGIOopHUIBZPiYcrz2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1525384749; bh=m6YtoPM1Kx4q5SFQC/ND66/pR3Ll3zQY9NuofXOgPY
    E=; b=ML7n5BAh6kcv6sSdQY36ByeW333d1cidNVIZ0troxYzJst3mM3Fs8VmCfU
    y9IRG/MJCm77dLsQC9SwjkCwhZSJqtX4EZP0ezQplkfP7l8Jrd/Mpid6ZRzD03DL
    W/2b4hDT3rbtpDJRhWHdVoEl1Qxzk9UV1YDysk78ylE1bzd+EtUa3vX2H1CE2K/V
    jWejrj5Ds+WXZ875BA3CWh3w93umNt19Jytt0TuBu0P3VHswvtiFJIo2lQ3lGR3K
    lzZ8bhGBAi70h2NelwLpJGqMjbXHCprqCynTLWbvkrXi3W0zvziwuncXqAuylxpe
    MzSpCypcrdvsbIrD9uU7hwuLF+pA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEOwXsi4TeTj0voa2N2CaPqLFmCDbFxGmGW1NEqK3cRIpeA/0dq1AZOtJbJJVLVmMVyKvTm8FHZTq1TABaV9z0VY/+JzlJyUmrgWmpGvd/jHHUZ9KGXw
    Yf6f5vMYsiMP3jthzZRYzlaYZjTMGasutT72UCje1tLm1xtcCCxe2covdDBTJfvGf2DFzfwtjrICtrLH/3juvz0Ud/es8RVWj8lYfc4DBHPhgNKKompJ80XJ
    LQqagsfnbn/CdoJRzSlwzw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=1XWaLZrsAAAA:8
    a=PtDNVHqPAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=zpPTWrBIHONCbDHKR4AA:9
    a=QjWodh3xu9JfAFf9:21 a=xaSVUV0ITnvzrM0V:21 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeECV7G (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 17:59:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49392 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECV7F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 17:59:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <87r2mso5up.fsf@xmission.com>
        <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
Date: Thu, 03 May 2018 16:58:56 -0500
In-Reply-To: <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
        (Matthew Garrett's message of "Thu, 03 May 2018 20:39:48 +0000")
Message-ID: <876044l7tr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEMFj-00049U-Hg;;;mid=<876044l7tr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LOxRAoenxX49z7AISsDfqQqRn4pd+cnY=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Matthew Garrett <mjg59@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 653 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.6 (0.4%), parse: 1.64 (0.3%),
        extract_message_metadata: 28 (4.3%), get_uri_detail_list: 4.0 (0.6%),
        tests_pri_-1000: 11 (1.6%), tests_pri_-950: 2.2 (0.3%), tests_pri_-900: 1.78
        (0.3%), tests_pri_-400: 38 (5.8%), check_bayes: 36 (5.4%), b_tokenize: 14
        (2.1%), b_tok_get_all: 9 (1.4%), b_comp_prob: 6 (0.9%), b_tok_touch_all: 2.8
        (0.4%), b_finish: 0.85 (0.1%), tests_pri_0: 553 (84.6%),
        check_dkim_signature: 1.14 (0.2%), check_dkim_adsp: 6 (0.9%), tests_pri_500:
        9 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Matthew Garrett <mjg59@google.com> writes:

> On Thu, May 3, 2018 at 1:13 PM Eric W. Biederman <ebiederm@xmission.com>
> wrote:
>
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>
>> > In environments that require the kexec kernel image to be signed,
> prevent
>> > using the kexec_load syscall.  In order for LSMs and IMA to
> differentiate
>> > between kexec_load and kexec_file_load syscalls, this patch set adds a
>> > call to security_kernel_read_file() in kexec_load_check().
>
>> Having thought about it some more this justification for these changes
>> does not work.  The functionality of kexec_load is already root-only.
>> So in environments that require the kernel image to be signed just don't
>> use kexec_load.  Possibly even compile kexec_load out to save space
>> because you will never need it.  You don't need a new security hook to
>> do any of that.  Userspace is a very fine mechanism for being the
>> instrument of policy.
>
>> If you don't trust userspace that needs to be spelled out very clearly.
>> You need to talk about what your threat models are.
>
> kexec_load gives root arbitrary power to modify the running kernel image,
> including the ability to disable enforcement of module signatures.

No.  It does absolutely nothing to the running kernel image.
Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
booting something different.  It is argubably a little more efficient
than writing to a file to direct the bootloader to boot something
different and then calling reboot.  But it is not fundamentally
different.

> Given
> that it weakens other security mechanisms that are designed to prevent root
> from disabling them, it makes sense to allow the imposition of an
> equivalent restriction.

Say what.  You are saying a lot of words without any specifics.  Not a
specific threat mode.  Not which security mecahnisms you are worried
about weakening.  Not what classes of problems you are trying to defend
against.

I absolutely hate this nonsense.  I thought you already went 20 rounds
with Linus and learned you need to be upfront with what you are
concerned about.

I believe reasonable situations can be constructed.  But I am not seeing
that happen here.

My hand wavy argument to go with yours is that code paths that are root
only are not audited for security properties.  As such the number of
exploitable bus you can find in them is larger than normal.  It might be
a little harder to mount xfs or another filesystem with an exploitable
file system image but I expect it exists.

Further nothing I have seen you involved with has been about truly
hardening the system against a hostile root.  I have for the last
several years been chipping away at that and you have been nowhere to be
found.

So please be specific.  Talk about which threat you are worried about.
Because so far this looks like someones effort to look like they were
doing something without actually caring about real world threats.

Eric





