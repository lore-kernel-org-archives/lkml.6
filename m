Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934647AbeBPK6O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:58:14 -0500
Received: from server.atrad.com.au ([150.101.241.2]:36848 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:58:12 -0500
Date: Fri, 16 Feb 2018 21:27:47 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fujitsu-laptop: Miscellaneous cleanups
Message-ID: <20180216105747.GC25974@marvin.atrad.com.au>
References: <20180211210727.12130-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211210727.12130-1-kernel@kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:07:20PM +0100, Micha?? K??pie?? wrote:
> The patch series contains miscellaneous cleanups which I think are worth
> getting done before splitting fujitsu-laptop into two separate modules.
> I am not 100% sure that all the changes in the last patch in this series
> actually help, so please speak your mind.

With the relatively minor comments about patch 6 I've posted about
separately, I'm happy with this patch set.  Collectively these changes
improve the readability of the code and make its intent clearer.

> This patch series was tested on a Lifebook S7020.  AFAICT it does not
> conflict with the recent draft patch from Jan-Marek Glogowski and may
> thus be applied independently.

I agree.

I'm interested to hear your thoughts in connection with my queries about
patch 6 before merging.  That aside, I have no issues with this series.

Reviewed-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan
