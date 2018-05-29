Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965294AbeE2Q7Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936855AbeE2Q7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:59:21 -0400
Date: Tue, 29 May 2018 18:59:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Liu <liumartin@google.com>
Cc: heikki.krogerus@linux.intel.com, johan@kernel.org,
        stern@rowland.harvard.edu, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jenhaochen@google.com
Subject: Re: [RFC PATCH v3] driver core: hold dev's parent lock when needed
Message-ID: <20180529165900.GA15599@kroah.com>
References: <Pine.LNX.4.44L0.1805291003470.1458-100000@iolanthe.rowland.org>
 <20180529163428.234106-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529163428.234106-1-liumartin@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:34:29AM +0800, Martin Liu wrote:
> SOC have internal I/O buses that can't be proved for devices. The
> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under it desribed in DT
> (device tree).

<snip>

Hint, I don't apply "RFC" patches as obviously the author does not think
it is good enough to be merged :)
