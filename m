Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165937AbeBOSKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:10:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163370AbeBOSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:10:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="18781483"
Subject: Re: [PATCH RFC v2 1/6] x86: Skip PTI when disable indication is set
To: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-2-namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <7057a6cc-f3ea-8826-5440-61e0154950da@linux.intel.com>
Date: Thu, 15 Feb 2018 10:10:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215163602.61162-2-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 08:35 AM, Nadav Amit wrote:
> +.Lno_spec_\@:
> +	lfence
> +	jmp	.Lend_\@
> +
>  .Lnoflush_\@:
>  	SET_NOFLUSH_BIT \save_reg
>  

How expensive is this?
