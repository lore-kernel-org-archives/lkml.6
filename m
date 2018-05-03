Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3148351-1525383416-2-1445068911989821619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525383415; b=MGDnOLG7lPWtGX2+EdtFZlV+1kGCins5hZYukAdODsxok2c0GE
    32S3vSWM7QLPJxJ+4+xmbRajfdGAu0uu0/9KguZYsyoxba+5EJnQkIswArw2gdXp
    DHXZbY5r87w/OxJLD6QJitsvi+5oW4mvjKO3oeRaAWbertCNU4J/rs/UFJzioxnD
    Usgwpbi7crclmmU8bUutFbN+mfy8heg0CmzKfUlr/rWaYWH35yQKzNFlMNLBpuKm
    np3lbQpCl54gqVG0VhkB3Grpq1N/BWmcxtiU1lcO3SuSk/p3ahP+kff6fn5Sw0Cy
    LPaZtxH4DCSrAM+5aTsAc1Q6Snh5rQC1E9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1525383415; bh=UEqdUCpxtuGDUT+
    hLKgy1lkxQI698FfNTid7GtqXWLg=; b=nqFhFX/HB+Z3M/RE1/PubZc1917akyS
    EVD0KYS8QxM8V8XHM1FSzgNpjloGlrez0qcwTY+i/qENIu5uS1F5aOayBansyLcG
    yzvWnkCpxzYjL1n3ffgpTFNjt2jRWStbOu1/mZdprC9ngZDuBHSG0nVTFSoC/PTl
    TNnFY6eSeQt7poPz+IeID9ItLComBnEr6JViEc08jOxJ4qU0tbWhl2nZpqfsoUGx
    c7UjiTDcIcKpAWss/plCgZKAkm/bJ131CzqIaekABSHYq7OUHERTlhGNleqFqqFg
    2w2dz/kxJVN6r+/mnNK0PxDACUAk9HFbAZvG2XGRtHnJshyekNgTsCw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJipRG+ehOZ4hjnDd6zPdSvoXSIT/k/I6sa8l3Comms/TUPPX0eVsG/pJ6GsWHvV3ULBQPiXsqn1vOFDqAqwiCUYBaogXHA3+tFFnLGXNEqEBNwX95Db
    opmG6BO/kpnoubKBUj7Uj63cTAvPXDQGii2Ikt7oFHOdPSR/iaQxazNISKm8rwIswnGui4V2CCoUW5VTncvuoXndnCIQLD2zLXyk1sG5PpH+eZCY9Oj5NA+w
    cVCKsHXsbpI8TqfYidW4jg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=vt4SjZg1rlAb8qBVY98A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECVgw convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 3 May 2018 17:36:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47868 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeECVgv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 17:36:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
        <87h8nqglpx.fsf@xmission.com>
        <1525275904.5669.308.camel@linux.vnet.ibm.com>
        <87h8nospo5.fsf@xmission.com>
        <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
        <87y3h0pu72.fsf@xmission.com>
        <1525381619.3539.45.camel@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 16:36:40 -0500
In-Reply-To: <1525381619.3539.45.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Thu, 03 May 2018 17:06:59 -0400")
Message-ID: <87lgd0o1zr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fELuB-0008I7-TV;;;mid=<87lgd0o1zr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19CCsA61K5b02R6zf4APxrEyy4Aqhm93tA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 303 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (1.2%), b_tie_ro: 3.0 (1.0%), parse: 0.82 (0.3%),
        extract_message_metadata: 11 (3.7%), get_uri_detail_list: 2.2 (0.7%),
        tests_pri_-1000: 4.8 (1.6%), tests_pri_-950: 1.17 (0.4%), tests_pri_-900:
        0.97 (0.3%), tests_pri_-400: 36 (11.9%), check_bayes: 35 (11.5%), b_tokenize:
        15 (4.8%), b_tok_get_all: 9 (2.9%), b_comp_prob: 4.1 (1.4%), b_tok_touch_all:
        4.9 (1.6%), b_finish: 0.66 (0.2%), tests_pri_0: 238 (78.4%),
        check_dkim_signature: 0.65 (0.2%), check_dkim_adsp: 2.8 (0.9%),
        tests_pri_500: 4.1 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Thu, 2018-05-03 at 11:42 -0500, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>> 
>> > On 5/3/2018 8:51 AM, Eric W. Biederman wrote:
>> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> >>
>> >>> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
>> >>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> >>>>
>> >>>>> Allow LSMs and IMA to differentiate between the kexec_load and
>> >>>>> kexec_file_load syscalls by adding an "unnecessary" call to
>> >>>>> security_kernel_read_file() in kexec_load.  This would be similar to the
>> >>>>> existing init_module syscall calling security_kernel_read_file().
>> >>>> Given the reasonable desire to load a policy that ensures everything
>> >>>> has a signature I don't have fundamental objections.
>> >>>>
>> >>>> security_kernel_read_file as a hook seems an odd choice.  At the very
>> >>>> least it has a bad name because there is no file reading going on here.
>> >>>>
>> >>>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
>> >>>> anywhere.  Which means I could have a kernel compiled without that and I
>> >>>> would be allowed to use kexec_file_load without signature checking.
>> >>>> While kexec_load would be denied.
>> >>>>
>> >>>> Am I missing something here?
>> >>> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
>> >>> calls security_kernel_read_file().  So kexec_file_load and kexec_load
>> >>> syscall would be using the same method for enforcing signature
>> >>> verification.
>> >> Having looked at your patches and the kernel a little more I think
>> >> this should be a separate security hook that does not take a file
>> >> parameter.
>> >>
>> >> Right now every other security module assumes !file is init_module.
>> >> So I think this change has the potential to confuse other security
>> >> modules, with the result of unintended policy being applied.
>> >>
>> >> So just for good security module hygeine I think this needs a dedicated
>> >> kexec_load security hook.
>> >
>> > I would rather see the existing modules updated than a new
>> > hook added. Too many hooks spoil the broth. Two hooks with
>> > trivial differences just add to the clutter and make it harder
>> > for non-lsm developers to figure out what to use in their
>> > code.
>> 
>> These are not non-trivial differences.  There is absolutely nothing
>> file related about kexec_load.  Nor for init_module for that matter.
>> 
>> If something is called security_kernel_read_file I think it is wholly
>> appropriate for code that processes such a hook to assume file is
>> non-NULL.
>> 
>> When you have to dance a jig (which is what I see the security modules
>> doing) to figure out who is calling a lsm hook for what purpose I think
>> it is a maintenance problem waiting to happen and that the hook is badly
>> designed.
>> 
>> At this point I don't care what the lsm's do with the hooks but the
>> hooks need to make sense for people outside of the lsm's and something
>> about reading a file in a syscall that doesn't read files is complete
>> and utter nonsense.
>
> Sure, we can define a wrapper around the security_kernel_read_file()
> hook, calling it security_non-fd_syscall() or even
> security_old_syscall().

I really don't see why you want to use the same hook.

I just read through the code of all three users.  None of them.
Especially IMA shares any significant code between the !file case and
the file case.

Eric

