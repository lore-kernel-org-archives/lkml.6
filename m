Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163853AbeBOVlT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:41:19 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54356 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163784AbeBOVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:41:17 -0500
X-Google-Smtp-Source: AH8x227DUlhKm59y+uJP6/1/+X8fyNhFr6LBHr3XUad4XP+p0aD2TPvqvWQWDnIlrL91kQmc1I3HTg==
Date: Fri, 16 Feb 2018 00:41:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
Message-ID: <20180215214113.GA27190@avx2>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
 <20180215190713.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215190713.GF30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:07:13PM +0000, Al Viro wrote:
> On Wed, Feb 14, 2018 at 11:19:35AM +0300, Alexey Dobriyan wrote:
> 
> > The more the merrier.
> 
> ITYM "Sanity is overrated anyway."

If you view annotations as debugging option the thing is not that bad.
