Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbeCFI6b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:58:31 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53727 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeCFI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:58:30 -0500
X-Google-Smtp-Source: AG47ELuRq4r1DRQGluV/S0hSXZ9lAXhkQJywPDDF4jnPTTFY1mIJ3zUauMIAyiL+fscrNHNrV7PbrQ==
Date: Tue, 6 Mar 2018 11:58:13 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 00/22] Partial MKTME enabling
Message-ID: <20180306085813.d22slphcsrtzrtaq@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305183050.GA22743@infradead.org>
 <20180305190549.GA10418@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305190549.GA10418@bombadil.infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:05:50AM -0800, Matthew Wilcox wrote:
> On Mon, Mar 05, 2018 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > On Mon, Mar 05, 2018 at 07:25:48PM +0300, Kirill A. Shutemov wrote:
> > > Hi everybody,
> > > 
> > > Here's updated version of my patchset that brings support of MKTME.
> > 
> > It would really help if you'd explain what "MKTME" is..
> 
> You needed to keep reading, to below the -------------- line.
> 
> I agree though, that should have been up top.

My bad. Will update it for future postings.

-- 
 Kirill A. Shutemov
