Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeEPIHG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:07:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:15592 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752382AbeEPIG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:06:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41657583"
Date: Wed, 16 May 2018 11:06:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/boot/compressed/64: Fix trampoline page table
 address calculation
Message-ID: <20180516080654.3e3pgvalgoxdhfvf@black.fi.intel.com>
References: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
 <20180516080131.27913-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516080131.27913-4-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch. Please ignore this and the next patch. It was sent by mistake.
Sorry.

-- 
 Kirill A. Shutemov
