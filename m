Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeFAGII (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeFAGIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:08:04 -0400
Date: Fri, 1 Jun 2018 08:07:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabin Mihai Rapan <sabin.rapan@gmail.com>
Cc: Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtlwifi: Fix "Trafic"->"Traffic"
Message-ID: <20180601060740.GA25648@kroah.com>
References: <20180531110314.3760-1-sabin.rapan@gmail.com>
 <20180531165747.GA28898@kroah.com>
 <438a4c2c-5bf8-8149-aaff-1f58493cdc79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438a4c2c-5bf8-8149-aaff-1f58493cdc79@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:48:23PM +0200, Sabin Mihai Rapan wrote:
> In the first patch series I forgot to CC linux-kernel@vger.kernel.org and
> assumed (wrongly) that the patch series will be ignored.
> In an attempt to fix that, I sent the second patch series with proper
> CC added. I should have sent it as a reply to the first one and version
> it.
> I will do as you said and resend the patch series.

linux-kernel does not care about staging patches :)

Please use scripts/get_maintainers.pl to determine who to cc: and the
proper mailing list to use.

thanks,

greg k-h
