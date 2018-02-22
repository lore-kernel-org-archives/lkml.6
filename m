Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBVUzl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:55:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeBVUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:55:39 -0500
Date: Thu, 22 Feb 2018 12:55:35 -0800
From: Darren Hart <dvhart@infradead.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fujitsu-laptop: Miscellaneous cleanups
Message-ID: <20180222205535.GH19843@fury>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 06:24:47AM +0100, Michał Kępień wrote:
> This patch series contains miscellaneous cleanups which I think are
> worth getting done before splitting fujitsu-laptop into two separate
> modules.
> 
> Changes from v1:
> 
>   - [6/7] Rename BACKLIGHT_POWER to BACKLIGHT_PARAM_POWER.
> 
>   - [6/7] Use BACKLIGHT_OFF instead of a numeric constant.
> 
>   - [7/7] Include <linux/bitops.h> due to the use of BIT().
> 
>  drivers/platform/x86/fujitsu-laptop.c | 180 +++++++++++++++++-----------------
>  1 file changed, 91 insertions(+), 89 deletions(-)

Queued for 4.17, thanks.

-- 
Darren Hart
VMware Open Source Technology Center
