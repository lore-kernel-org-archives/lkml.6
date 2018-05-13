Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeEMW0d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:26:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42064 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeEMW0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:26:32 -0400
Date: Sun, 13 May 2018 23:26:30 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cramfs: Fix IS_ENABLED typo
Message-ID: <20180513222630.GY30522@ZenIV.linux.org.uk>
References: <6cb70923c547bb95496833593f994f4e2de6b0ab.camel@perches.com>
 <nycvar.YSQ.7.76.1805131818520.3749@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1805131818520.3749@knanqh.ubzr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 06:21:18PM -0400, Nicolas Pitre wrote:
> On Sun, 13 May 2018, Joe Perches wrote:
> 
> > There's an extra C here...
> > 
> > Fixes: 99c18ce580c6 ("cramfs: direct memory access support")
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Indeed.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> @Al: could you pick up this one too?

Put into #fixes...
