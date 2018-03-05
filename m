Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeCETF7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:05:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCETF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:05:57 -0500
Date: Mon, 5 Mar 2018 11:05:50 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 00/22] Partial MKTME enabling
Message-ID: <20180305190549.GA10418@bombadil.infradead.org>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305183050.GA22743@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305183050.GA22743@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:30:50AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 05, 2018 at 07:25:48PM +0300, Kirill A. Shutemov wrote:
> > Hi everybody,
> > 
> > Here's updated version of my patchset that brings support of MKTME.
> 
> It would really help if you'd explain what "MKTME" is..

You needed to keep reading, to below the -------------- line.

I agree though, that should have been up top.
