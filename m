Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeBFOxE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:53:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeBFOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:52:58 -0500
Subject: Re: [PATCH 0/2] Fix a couple of crashes in netfront
To: Ross Lagerwall <ross.lagerwall@citrix.com>,
        xen-devel@lists.xenproject.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180111093638.28937-1-ross.lagerwall@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <71df329e-305a-45d8-6e47-4505bd45e560@suse.com>
Date: Tue, 6 Feb 2018 15:52:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180111093638.28937-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/18 10:36, Ross Lagerwall wrote:
> Here are a couple of patches to fix two crashes in netfront.
> 
> Ross Lagerwall (2):
>   xen/grant-table: Use put_page instead of free_page
>   xen-netfront: Fix race between device setup and open
> 
>  drivers/net/xen-netfront.c | 46 ++++++++++++++++++++++++----------------------
>  drivers/xen/grant-table.c  |  4 ++--
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 

Both committed to xen.tip for-linus-4.16


Juergen
