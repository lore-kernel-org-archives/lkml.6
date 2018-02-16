Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422991AbeBPAVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:21:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:23069 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422716AbeBPAVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:21:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18129076"
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
To: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
References: <20180215163602.61162-1-namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
Date: Thu, 15 Feb 2018 16:21:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 08:35 AM, Nadav Amit wrote:
> I removed the PTI disabling while SMEP is unsupported, although I
> must admit I did not fully understand why it is required.

Do you mean you don't fully understand how PTI gives SMEP-like behavior
on non-SMEP hardware?
