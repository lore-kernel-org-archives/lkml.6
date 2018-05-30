Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeE3MEq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeE3MDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:03:55 -0400
Date: Wed, 30 May 2018 14:03:34 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Rohit Khatri <rohit.khatri@mbconnectline.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4.17-rc7 1/1] lib/kobject_uevent : fix uevent
 environment variable update with kobject event
Message-ID: <20180530120334.GA24919@kroah.com>
References: <c195ec31-9ea9-e728-b28b-2f093ed1f8a2@mbconnectline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c195ec31-9ea9-e728-b28b-2f093ed1f8a2@mbconnectline.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:36:26AM +0000, Rohit Khatri wrote:
> From: Rohit Khatri <rohit.khatri@mbconnectline.com><mailto:rohit.khatri@mbconnectline.com>
> Subject: [PATCH 4.17-rc7 1/1] lib/kobject_uevent : fix uevent environment variable update with kobject event

What are these lines doing in the email body?

> Function kobject_uevent_env is unable to update uevent variables as sequence of code is overwriting user added environment variable(s).
> For example, if there is a variable named "KEY" in uevent environment with initial value of 0 and if update on any event using  kobject_uevent_env function, value of variable would be 0 only or whatever is initialized because after loading user called variable, function is again reloading same variables.

Please always wrap your changelog lines at the proper column, like your
editor asked you to when you wrote the patch.

> Signed-off-by: Rohit Khatri <rohit.khatri@mbconnectline.com><mailto:rohit.khatri@mbconnectline.com>
> Cc: stable@vger.kernel.org<mailto:stable@vger.kernel.org>

What is with the crazy mailto: stuff?

Please fix up and we can review the patch...

Also, does this "fix" a patch that is already in the tree?  If so,
please use the Fixes: tag to specify what commit it fixes.

thanks,

greg k-h
