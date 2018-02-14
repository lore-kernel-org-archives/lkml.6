Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967325AbeBNK5Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:57:24 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:42908 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967159AbeBNK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:57:23 -0500
X-Google-Smtp-Source: AH8x224NfjARmywDeMB4lFZyey5ducsna5/M6BDASmG5wUpp+0Ou2KgrIKIHufEGV9kdWc6Uygv1Yw==
Date: Wed, 14 Feb 2018 13:57:19 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: Use PAGE_SIZE instead of 4096 where appropriate
Message-ID: <20180214105719.GA32767@uranus>
References: <20180214103253.42066-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214103253.42066-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 01:32:53PM +0300, Kirill A. Shutemov wrote:
> Cyrill pointed that it makes sense to replace 4096 to PAGE_SIZE in
> head_64.S.
> 
> This patch replaces 4096 with PAGE_SIZE everywhere in assembly code
> where it fits semantically.
> 
> Suggested-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Thanks a lot!
Reviewed-by: Cyrill Gorcunov <gorcunov@openvz.org>
