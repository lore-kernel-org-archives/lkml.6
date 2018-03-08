Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936014AbeCHR4i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:56:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeCHR4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:56:37 -0500
Subject: Re: linux-next: Tree for Mar 8 (md/dm-mpath.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Thornber <dm-devel@redhat.com>
References: <20180308163336.2943012b@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4f96fc4-8e90-4682-8190-5ae99b804136@infradead.org>
Date: Thu, 8 Mar 2018 09:56:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308163336.2943012b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 09:33 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180307:
> 

on i386: when CONFIG_SCSI is not enabled:

drivers/md/dm-mpath.o: In function `multipath_ctr':
dm-mpath.c:(.text+0x1ab7): undefined reference to `scsi_device_from_queue'


-- 
~Randy
