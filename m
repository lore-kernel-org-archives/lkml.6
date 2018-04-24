Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756642AbeDXMMH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:12:07 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52516 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755997AbeDXMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:11:55 -0400
X-Google-Smtp-Source: AIpwx48FiOYGY054gnM1Xdkh+WJ/SbQV79gvmXrkDGjFSm7WCY0HP9q/f00Rp9+tkr6YFjYvOUW93g==
Date: Tue, 24 Apr 2018 14:11:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] gpu: drm: qxl: Adding new typedef vm_fault_t
Message-ID: <20180424121151.GX31310@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
References: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
 <20180423104924.ozalv7x5ppjifnxc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423104924.ozalv7x5ppjifnxc@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 12:49:24PM +0200, Gerd Hoffmann wrote:
> On Tue, Apr 17, 2018 at 07:08:44PM +0530, Souptick Joarder wrote:
> > Use new return type vm_fault_t for fault handler. For
> > now, this is just documenting that the function returns
> > a VM_FAULT value rather than an errno. Once all instances
> > are converted, vm_fault_t will become a distinct type.
> > 
> > Reference id -> 1c8f422059ae ("mm: change return type to
> > vm_fault_t")
> 
> Hmm, that commit isn't yet in drm-misc-next.
> Will drm-misc-next merge with 4.17-rcX soon?

For backmerge requests you need to cc/ping the drm-misc maintainers.
Adding them. I think the hold-up also was that Dave was on vacations
still.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
