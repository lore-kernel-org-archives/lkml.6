Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeCFPER (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:04:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:43637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932830AbeCFPEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:04:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="23370176"
Subject: Re: [RFC, PATCH 21/22] x86/mm: Introduce page_keyid() and
 page_encrypted()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-22-kirill.shutemov@linux.intel.com>
 <61041640-435e-1a67-177f-a75791130514@intel.com>
 <20180306085751.tvozsfe6hogh37pd@node.shutemov.name>
 <91d27559-3f28-d53c-9fd9-d16e015a3f59@intel.com>
 <20180306145806.ejg5kzaqqmncgqi7@black.fi.intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <945b233a-e596-6426-b51d-f9a3ab2be94b@intel.com>
Date: Tue, 6 Mar 2018 07:04:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306145806.ejg5kzaqqmncgqi7@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 06:58 AM, Kirill A. Shutemov wrote:
>> Doesn't it really mean "am I able to use the direct map to get this
>> page's contents?"
> Yes.
> 
> Any proposal for better helper name?

Let's see how it gets used.
