Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032443AbeEZU5N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 16:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032387AbeEZU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 16:57:11 -0400
Date: Sat, 26 May 2018 22:56:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: gadget: ccid: add support for USB CCID Gadget
 Device
Message-ID: <20180526205652.GA25534@kroah.com>
References: <20180526203401.16586-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526203401.16586-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 10:33:59PM +0200, Marcus Folkesson wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

I can't take patches without any changelog text.  And why would you
submit a patch over 1000 lines without any?

Please fix.

thanks,

greg k-h
