Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4073160-1523637664-2-9385312133692741750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523637663; b=EbfIhGa2XsXqEA7t3UyrsQyyrwoNy7ZHs+wLccMzyryQne6oj8
    H+KS6XAsTXPJJ8SyuAJUib5brCMbYN+l4G2faZ8xK5xw0PiLjB3hKC4+ba7IMFmr
    sx0XyJCBCzaPpheFFQLF+WzApZVDdsucZpPPQxiXM+aoefZo3+WqH/JVeom3YzqB
    jwdMTZlBxAcBGD3L/CTRHGevDQYv7rJantUKsr9WgZY/oHX+OPuiK/0c8JiP/gJW
    gEMfAKwBn5MyVzDzAz8htUV88CZ310Webn/4OPx0x2KJVaz7AxiJAjNekZE/WAt2
    bb85lnIvpy13u1U1jp9liEuqj7djK2thgvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523637663; bh=vU6Z7x3T6whHR+cVI2Q1V0JawXRaXN3OkD0PU58Rf2
    4=; b=Bohpbq0+DlUXqxUsG7C1syb+TPfs/X4QGJEUxFFqkxtW7vI7GTDqm2u1Ow
    erC3VFjG8k/dUoM26A4sx1lxzQX3YQ1DWH2UBsH98Ym8MRBJMrleLn9I+SBUIKMO
    pWjE6oyk4Wkr1jPuCHW6fWGGTwmakVSYSGh29oxcmI/FBbfg7sUhKIra0EgzWkkH
    4fB18pcNty7uax9grbPA/M+iOUw9ZdFQJuLTEl83wtybJykbYkLFuHALCZ3C00lf
    rAI5a5l7pdgX4tkpXS2OjFrh5TkMk992M3FONXsCAgad3RuwQyEOx644A7pGrTNB
    pJDrY5+CUL9SYA8nS2/FvdRI3/Pw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eXacGvQm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QxszPNZm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ngeu4yhR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eXacGvQm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QxszPNZm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ngeu4yhR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPRnZc2KTVW+dAC7fB/Wulye13AIoRNkS/6U0A9ITD2/+6N5ybuQ8V0QDteMuaTYfSG+be5yk6Z1pTI1Dp93p1C5KvTe+0N8adDr2I4pCYJJGXrT3jss
    CXG1uKLimohEhcYie2vfyMWM+D4CYnD0tJAQRbA5Fdt5K9FVRlRmkMIqpud0drRVq5iRF5vSy8O4jpt37yUxMSkGurlS0JnWCeDkSNGDTIReDds01ccIJxJ/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=_3gjB1yF-KniojIHO_0A:9
    a=JbhVBeq_7PR-RcT4:21 a=jK22C4LmDl5KcL6H:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDMQhb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:37:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37294 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbeDMQha (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 12:37:30 -0400
X-Google-Smtp-Source: AIpwx48DSOCUPgM2F2S63dDyedIyUj4N0Qf4Kq7+DVnIFo8z3m77VN9N8e1U93ugiZetoNdqrEOUPaJkKOBe81DWgVg=
MIME-Version: 1.0
In-Reply-To: <625160026.9658.1523621809662.JavaMail.zimbra@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
 <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com>
 <CA+55aFwFUeNA6_0a1MOU-7VGzCw5T99cfVCPiyTpZQJdd6z=bw@mail.gmail.com> <625160026.9658.1523621809662.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 09:37:28 -0700
X-Google-Sender-Auth: GbfICpy5mq845uesyhA6TMeF5Nw
Message-ID: <CA+55aFwXCnnfrOjPj5SB=G34xgveo1jqNyf23YNt6jOKX_VdGw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 5:16 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> The vmalloc space needed by cpu_opv is bound by the number of pages
> a cpu_opv call can touch.

No it's not.

You can have a thousand different processes doing cpu_opv at the same time.

A *single* cpu_opv may me limited toi "only" a megabyte, but I'm not
seeing any global limit anywhere.

In short, this looks like a guaranteed DoS approach to me.

                   Linus
