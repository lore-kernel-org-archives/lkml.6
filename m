Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbeDWKtb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:49:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754710AbeDWKt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:49:26 -0400
Date: Mon, 23 Apr 2018 12:49:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: airlied@redhat.com, airlied@linux.ie,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] gpu: drm: qxl: Adding new typedef vm_fault_t
Message-ID: <20180423104924.ozalv7x5ppjifnxc@sirius.home.kraxel.org>
References: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 07:08:44PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")

Hmm, that commit isn't yet in drm-misc-next.
Will drm-misc-next merge with 4.17-rcX soon?

cheers,
  Gerd
