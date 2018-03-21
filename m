Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCUAkn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbeCUAkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:40:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A65721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELusiYcN5izEh78zjXG/5Rilt18TAyctwJMI5BavgeuezZvuZ+C3y1PyD3loLyy2C/AdFfqteznwyGh4yqU9dLk=
MIME-Version: 1.0
In-Reply-To: <3EEB68A1-2C6B-4E8F-B400-1893E49DA1B2@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXCRYvLthy2FMccoDhnPzyPT5J_hcvD63e-DM9okVaxeg@mail.gmail.com>
 <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com> <3EEB68A1-2C6B-4E8F-B400-1893E49DA1B2@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Mar 2018 00:40:18 +0000
X-Gmail-Original-Message-ID: <CALCETrU9DiumP9ODKm-dW-MubJSmkFKjGkSJyw34-WbxAK0Xrw@mail.gmail.com>
Message-ID: <CALCETrU9DiumP9ODKm-dW-MubJSmkFKjGkSJyw34-WbxAK0Xrw@mail.gmail.com>
Subject: Re: [PATCH 00/15] x86: Enable FSGSBASE instructions
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 4:33 PM, Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> On 3/20/18, 08:07, "Andy Lutomirski" <luto@kernel.org> wrote:
>> Can you describe what changed since the last submission?  It looks
>> like a lot has changed and this series is much more complicated and
>> much more fragile than it used to be.  Why?
>
> According to your overall comments, most concerning part you have right now
> is paranoid entry and ptrace legacy support. (correct me if I'm wong)
> Design-wise, I think they're major changes -- I can follow-up with
> a summary if you want. I responded about paranoid entry. ptrace
> legacy support is simply new that never before AFAIK.

Summary please.
