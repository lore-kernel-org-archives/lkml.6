Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeERF1j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:27:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeERF1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:27:38 -0400
Date: Thu, 17 May 2018 22:11:35 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, manfred@colorfullife.com,
        ebiederm@xmission.com, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] ipc: Adding new return type vm_fault_t
Message-ID: <20180518051135.npd3dmhz6kk32f6d@linux-n805>
References: <20180425043413.GA21467@jordon-HP-15-Notebook-PC>
 <CAFqt6zai16qZ--L9aAh0dtD9XTfu-vpUpO4CWgOHKavxH5AU1Q@mail.gmail.com>
 <CAFqt6zYLDsQ+LRPMJF+H-9hKt03HwGPaj1eaxPGMuu039a8j2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFqt6zYLDsQ+LRPMJF+H-9hKt03HwGPaj1eaxPGMuu039a8j2g@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Souptick Joarder wrote:

>On Thu, May 10, 2018 at 7:34 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Wed, Apr 25, 2018 at 10:04 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
