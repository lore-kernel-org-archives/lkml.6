Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEMUCn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:02:43 -0400
Received: from imap.thunk.org ([74.207.234.97]:46550 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeEMUCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:02:42 -0400
Date: Sun, 13 May 2018 16:02:36 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] fs: ext4: Adding new return type vm_fault_t
Message-ID: <20180513200236.GF14763@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20180510144136.GA26160@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510144136.GA26160@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:11:36PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For now,
> this is just documenting that the function returns a
> VM_FAULT value rather than an errno. Once all instances are
> converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Applied, thanks.

					- Ted
