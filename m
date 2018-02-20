Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeBTG1w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 01:27:52 -0500
Received: from server.atrad.com.au ([150.101.241.2]:39858 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 01:27:51 -0500
Date: Tue, 20 Feb 2018 16:57:04 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fujitsu-laptop: Miscellaneous cleanups
Message-ID: <20180220062704.GK3785@marvin.atrad.com.au>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 06:24:47AM +0100, Micha?? K??pie?? wrote:
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

Thanks for the revision; the result looks good to me.  Collectively these
changes improve the readability of the code and make its intent clearer.

Reviewed-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan
