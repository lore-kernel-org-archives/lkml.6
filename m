Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeCETH7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:07:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:41707 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCETH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:07:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32575331"
Subject: Re: [RFC, PATCH 18/22] x86/mm: Handle allocation of encrypted pages
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6551765a-5926-8445-d867-8f7c6bf343b4@intel.com>
Date: Mon, 5 Mar 2018 11:07:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> kmap_atomic_keyid() would map the page with the specified KeyID.
> For now it's dummy implementation that would be replaced later.

I think you need to explain the tradeoffs here.  We could just change
the linear map around, but you don't.  Why?
