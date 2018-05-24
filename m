Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970628AbeEXPBu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966848AbeEXPBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:01:49 -0400
Date: Thu, 24 May 2018 17:01:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tariq Toukan <tariqt@mellanox.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.16 008/161] packet: in packet_snd start writing at link
 layer allocation
Message-ID: <20180524150131.GA14124@kroah.com>
References: <20180524093018.331893860@linuxfoundation.org>
 <20180524093019.375532134@linuxfoundation.org>
 <c380ed51-85f5-b63a-d424-77c7450e63c9@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c380ed51-85f5-b63a-d424-77c7450e63c9@mellanox.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 05:53:15PM +0300, Tariq Toukan wrote:
> 
> 
> On 24/05/2018 12:37 PM, Greg Kroah-Hartman wrote:
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> Please hold on with this.
> I think it causes some degradation.
> 
> I'll report the issue on the original patch.

As it's good to be "bug compatible" with Linus's tree, I'll just assume
that any patch based on the outcome of that discussion will be applied
there, and I can backport it then.

thanks,

greg k-h
