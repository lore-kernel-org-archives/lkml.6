Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeEaQ6R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755785AbeEaQ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:58:13 -0400
Date: Thu, 31 May 2018 18:57:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabin Mihai Rapan <sabin.rapan@gmail.com>
Cc: Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtlwifi: Fix "Trafic"->"Traffic"
Message-ID: <20180531165747.GA28898@kroah.com>
References: <20180531110314.3760-1-sabin.rapan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531110314.3760-1-sabin.rapan@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 01:03:12PM +0200, Sabin Mihai Rapan wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
> ---
>  drivers/staging/rtlwifi/phydm/phydm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent a previous set of 4 patches with these same exact subject lines
:(

I've now dropped both of these series from my pending queue, please fix
up the subject lines and resend all of them at once.

thanks,

greg k-h
