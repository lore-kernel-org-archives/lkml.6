Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755814AbeEaRBL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755600AbeEaRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:01:07 -0400
Date: Thu, 31 May 2018 19:00:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jefferson Capovilla <jefcap@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-eth: fix line over 80 char in
 mtk_set_link_ksettings()
Message-ID: <20180531170041.GA1938@kroah.com>
References: <20180527175908.GA11653@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527175908.GA11653@jefcap-VirtualBox>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 02:59:08PM -0300, Jefferson Capovilla wrote:
> Fix 'line over 80 characters' issue found by checkpatch.pl script in
> mtk_set_link_ksettings().
> 
> Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
> ---
>  drivers/staging/mt7621-eth/ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This patch does not apply to my staging-next branch at all :(

Please fix up and resend.

thanks,

greg k-h
