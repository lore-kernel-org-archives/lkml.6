Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbeDMNYL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:24:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50306 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbeDMNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:24:10 -0400
X-Google-Smtp-Source: AIpwx48qBEY1zMQHvP7Y/gW1QQvkTeOVFO+eMBgoSDKBoWGDl0NCbEXGp4k0S5Miwn0zQVyPU7CYIA==
Date: Thu, 12 Apr 2018 17:28:01 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jiri Kosina <jikos@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: vmemmap and vmalloc base addressess are usngined
 longs
Message-ID: <20180412142801.oi7bzju3frgkdskp@node.shutemov.name>
References: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 02:39:10PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Commits 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time") and 
> a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time") lost the 
> type information for __VMALLOC_BASE_L4, __VMALLOC_BASE_L5, 
> __VMEMMAP_BASE_L4 and __VMEMMAP_BASE_L5 constants.
> 
> Let's declare them explicitly unsigned long again.

It is just cosmetics, right? I mean these literals are 'unsigned long'
anyway.

-- 
 Kirill A. Shutemov
