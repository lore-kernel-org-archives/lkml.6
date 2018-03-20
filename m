Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeCTQd7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:33:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:28851 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeCTQdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:33:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,336,1517904000";
   d="scan'208";a="184475183"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] x86: Enable FSGSBASE instructions
Thread-Topic: [PATCH 00/15] x86: Enable FSGSBASE instructions
Thread-Index: AQHTv61V3qMp+UmTzky3sKjvzQBrlKPZnvsAgAAAXQD//6L7AA==
Date: Tue, 20 Mar 2018 16:33:48 +0000
Message-ID: <3EEB68A1-2C6B-4E8F-B400-1893E49DA1B2@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXCRYvLthy2FMccoDhnPzyPT5J_hcvD63e-DM9okVaxeg@mail.gmail.com>
 <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com>
In-Reply-To: <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD8BBE1E9A40A448C1193E90272CBC7@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KGY1M6025670

On 3/20/18, 08:07, "Andy Lutomirski" <luto@kernel.org> wrote:
> Can you describe what changed since the last submission?  It looks
> like a lot has changed and this series is much more complicated and
> much more fragile than it used to be.  Why?

According to your overall comments, most concerning part you have right now
is paranoid entry and ptrace legacy support. (correct me if I'm wong)
Design-wise, I think they're major changes -- I can follow-up with 
a summary if you want. I responded about paranoid entry. ptrace
legacy support is simply new that never before AFAIK.

> Also, I've been getting lots of kbuild bot complaints about something
> that looks like this patches from your git tree as recently as March
> 17.  Have you fixed those problems?

Last week, I don't have any major issue at all. I don't know what major
issues you saw. Most likely it is just silly rebase issue I bet.
