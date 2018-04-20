Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1800609-1524235071-2-13734586201405217255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524235071; b=lkPizyv3wMB/7+avsKt4nS7XnZMH74THu8aQAR6ksh8LCpHGWh
    qecTPBg4fQ7580uEv6uhKY1iV6dz+vjCtToCH26Rq8eVupunHOTQk7Fzq4RHuP3G
    /rqd6ABdJlpBsqI4QQUFIBOcQkH3EFNJvwToEl5Fk/Ugx9mSkiaN9ONbDvcghb9w
    Z5QZBVkPutRc9q4T3TSioLTn0AVKQetRwWn17yPNsus8viGIra6EL5KBYzgOE59o
    dl9fCpbQHC4HGVH+C8d4ylnnYk/Z4AZ6M6+oAXFE4rvF1+FFgYjcAMyFJtFTtuO3
    gW3ztURgm26OIjmIBHKZtMfru+ZElbi0uPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1524235071; bh=nSwHxl8AYQxkOdgmPC502OcbykXRtLDtDFUiU4EbMt
    w=; b=cnf/LGKxYnjPsNWsl/b+EniKNOPJkfMelpVaNvijPUMrKiypm+qzren3ap
    ZGGL59xbaVNS66LlR6OeoJHby0JTN3bgFFMoDx4W+ylwXEijzCFKRQCy0LmKdKG7
    rNJcUO01y+czDVzWCq534NpIKIt5Mw0xhFJQLCBF+dP9GZ1hSGUfPjs8FKypgAxD
    IJxhSkCRlIc3YW7xndFDbwxLPy8SHnaAe/ZBmqk2lqcaoexnZ2ZImzJCZuhN/WO/
    C3/Su8XKlflTA+mpGqeBRikCs+pNRv8sC2XBOY7ZR+ooOVPn96nuim5ar/ANbNYY
    06bBOnUZoVYxcL7AZZuIryjkH5XQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMmTL1ekRdijUCXxNTKkrl5/uxR33AxUIzjDQsIxDZnz2Jd7lQCeeqZ9dXAUG+VFcjc83gFLimTBRUME0L/PQJlZUBbmwXHsKgaI1OezhEZOAW9dbzPy
    WfaXIDo4p7YI3Ae2l/idpJnBtmScPP/Nf8mRphuTvW+q9CM9+WeQ43WqI7+omhZAR1nCcxXKdupaMlIc0nFP8FMEVyXI7v/QQKkbLhHAk4bt62330LvHj0U7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gnzlnHAVoxylFr31GFgA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeDTOhs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 10:37:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35340 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755338AbeDTOhp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 10:37:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: <linux-arch@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, Albert Ou <albert@sifive.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <jejb@parisc-linux.org>,
        James Hogan <jhogan@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        stable@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        user-mode-linux-devel@lists.sourceforge.net,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <878t9ilmhv.fsf@xmission.com>
Date: Fri, 20 Apr 2018 09:35:52 -0500
In-Reply-To: <878t9ilmhv.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 19 Apr 2018 20:01:16 -0500")
Message-ID: <87604mhrnb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9XA6-00064a-5p;;;mid=<87604mhrnb.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+071iPiIPCK/nXuGRyDSgK32+6mbXObVc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMNoVowels,XMSolicitRefs_0
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;<linux-arch@vger.kernel.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 6 (0.0%), b_tie_ro: 4.9 (0.0%), parse: 0.82 (0.0%),
        extract_message_metadata: 3.8 (0.0%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 6 (0.0%), tests_pri_-950: 1.19 (0.0%), tests_pri_-900: 1.03
        (0.0%), tests_pri_-400: 32 (0.2%), check_bayes: 31 (0.2%), b_tokenize: 13
        (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        3.8 (0.0%), b_finish: 0.63 (0.0%), tests_pri_0: 366 (2.4%),
        check_dkim_signature: 0.51 (0.0%), check_dkim_adsp: 3.1 (0.0%),
        tests_pri_500: 14598 (97.2%), poll_dns_idle: 14591 (97.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 00/22] Simplifying siginfo users
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This patchset is almost completely updating the various pieces of
architecture code from filling out a struct siginfo and then calling
force_sig_info.  To using the helper force_sig_fault instead.  Which
takes the values that would have gone in siginfo as arguments.

As the diffstat below shows this noticeable reduces the amount of code.

There are a couple of minor and straight forward bug fixes as well
that I came across while working on the aforementioned changes.

This applies on my last round of siginfo changes simply to remove the
possibility of conflicts.  The changes should be semantically separate.

I intend to merge these changes through my siginfo tree.  If you have
any objections or would prefer to carry these changes in your
architecture trees please let me know.

The changes are also available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-review2

Eric W. Biederman (22):
      signal/alpha: Use send_sig_fault where appropriate
      signal/alpha: Use force_sig_fault where appropriate
      signal/c6x: Use force_sig_fault where appropriate
      signal/hexagon: Use force_sig_fault as appropriate
      signal/m68k: Use force_sig_fault where appropriate
      signal/microblaze: Remove the commented out force_sig_info in do_page_fault
      signal/microblaze: Use force_sig_fault where appropriate
      signal/mips: Use force_sig_fault where appropriate
      signal/nds32: Use force_sig_fault where appropriate
      signal/nios2: Use force_sig_fault where appropriate
      signal/openrisc: Use force_sig_fault where appropriate
      signal/parisc: Use force_sig_mceerr where appropriate
      signal/parisc: Use force_sig_fault where appropriate
      signal/riscv: Use force_sig_fault where appropriate
      signal/s390: Use force_sig_fault where appropriate
      signal/sh: Use force_sig_fault where appropriate
      signal/sparc: Use send_sig_fault where appropriate
      signal/sparc: Use force_sig_fault where appropriate
      signal/um: Use force_sig_fault in relay_signal.
      signal/um: Use force_sig_fault where appropriate
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
      signal/xtensa: Use force_sig_fault where appropriate

 arch/alpha/kernel/osf_sys.c         |  10 +--
 arch/alpha/kernel/signal.c          |  22 +-----
 arch/alpha/kernel/traps.c           |  80 +++++---------------
 arch/alpha/mm/fault.c               |  15 +---
 arch/c6x/kernel/traps.c             |  10 +--
 arch/hexagon/kernel/traps.c         |  10 +--
 arch/hexagon/mm/vm_fault.c          |  21 ++----
 arch/m68k/kernel/traps.c            |  60 +++++++--------
 arch/m68k/mm/fault.c                |  25 +++----
 arch/microblaze/kernel/exceptions.c |   9 +--
 arch/microblaze/mm/fault.c          |  14 +---
 arch/mips/kernel/traps.c            |  65 +++++-----------
 arch/mips/mm/fault.c                |  19 ++---
 arch/nds32/kernel/traps.c           |  20 +----
 arch/nds32/mm/fault.c               |  19 ++---
 arch/nios2/kernel/traps.c           |   9 +--
 arch/openrisc/kernel/traps.c        |  33 +-------
 arch/openrisc/mm/fault.c            |  19 ++---
 arch/parisc/kernel/ptrace.c         |  11 +--
 arch/parisc/kernel/traps.c          |  63 +++++-----------
 arch/parisc/kernel/unaligned.c      |  16 +---
 arch/parisc/math-emu/driver.c       |   9 +--
 arch/parisc/mm/fault.c              |  55 +++++++-------
 arch/riscv/kernel/traps.c           |   9 +--
 arch/s390/kernel/traps.c            |  32 ++------
 arch/s390/mm/fault.c                |  23 ++----
 arch/sh/kernel/traps_32.c           |  19 ++---
 arch/sh/math-emu/math.c             |   9 +--
 arch/sh/mm/fault.c                  |  10 +--
 arch/sparc/kernel/process_64.c      |  10 +--
 arch/sparc/kernel/sys_sparc_32.c    |   9 +--
 arch/sparc/kernel/sys_sparc_64.c    |   8 +-
 arch/sparc/kernel/traps_32.c        | 114 +++++-----------------------
 arch/sparc/kernel/traps_64.c        | 145 +++++++-----------------------------
 arch/sparc/kernel/unaligned_32.c    |  12 +--
 arch/sparc/mm/fault_32.c            |  13 +---
 arch/sparc/mm/fault_64.c            |   9 +--
 arch/um/kernel/ptrace.c             |  13 +---
 arch/um/kernel/trap.c               |  54 ++++++--------
 arch/xtensa/kernel/traps.c          |  10 +--
 arch/xtensa/mm/fault.c              |  19 ++---
 41 files changed, 280 insertions(+), 852 deletions(-)

Eric
