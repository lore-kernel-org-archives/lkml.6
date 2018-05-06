Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeEGKcv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:32:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48665 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEGKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:32:46 -0400
Date: Sun, 6 May 2018 19:33:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Larry Woodman <lwoodman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Introduce 'no5vl kernel parameter
Message-ID: <20180506173315.GA14673@xo-6d-61-c0.localdomain>
References: <20180502161027.36395-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502161027.36395-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-02 19:10:27, Kirill A. Shutemov wrote:
> The kernel parameter allows to force kernel to use 4-level paging even
> if hardware and kernel support 5-level paging.
> 
> The option may be useful to workaround regressions related to 5-level
> paging.

There's typo in subject.
