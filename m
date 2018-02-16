Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeBPThc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:37:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBPTh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:37:29 -0500
Date: Fri, 16 Feb 2018 11:37:25 -0800
From: Darren Hart <dvhart@infradead.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fujitsu-laptop: Miscellaneous cleanups
Message-ID: <20180216193725.GE5786@fury>
References: <20180211210727.12130-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180211210727.12130-1-kernel@kempniu.pl>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:07:20PM +0100, Michał Kępień wrote:
> This is the second of the two patch series I started preparing back in
> June 2017 [1].  It took me this long to post it purely due to permanent
> spare time shortage, not because the changes are complicated. 
> 
> The patch series contains miscellaneous cleanups which I think are worth
> getting done before splitting fujitsu-laptop into two separate modules.
> I am not 100% sure that all the changes in the last patch in this series
> actually help, so please speak your mind.
> 
> This patch series was tested on a Lifebook S7020.  AFAICT it does not
> conflict with the recent draft patch from Jan-Marek Glogowski and may
> thus be applied independently.
> 
> Finally, please forgive me if it takes me weeks or months to address
> review comments.  It is also perfectly fine for reviews to take weeks or
> months ;)
> 

To avoid just having to review everything again in a few months ;-) I've queued
up patches 1-5. I'll await comments to 6 and a respin of 7 based on feedback.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
