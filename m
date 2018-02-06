Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeBFWQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:16:46 -0500
Received: from ozlabs.org ([103.22.144.67]:50521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753267AbeBFWQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:16:45 -0500
Date: Wed, 7 Feb 2018 09:16:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v4.16-rc1] media updates
Message-ID: <20180207091643.6b71df0a@canb.auug.org.au>
In-Reply-To: <20180206091130.75c0f1ae@vento.lan>
References: <20180206091130.75c0f1ae@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, 6 Feb 2018 09:11:30 -0200 Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
>
> 1) You may expect a merge conflict due to this patch:
> 	c23e0cb81e40 ("media: annotate ->poll() instances")
> 
>      See: https://lkml.org/lkml/2018/1/1/547

Looks like you missed this when doing the merge :-(

-- 
Cheers,
Stephen Rothwell
