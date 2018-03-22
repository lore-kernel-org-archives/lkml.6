Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCVRgu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:36:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeCVRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:36:48 -0400
Subject: Re: linux-next: Tree for Mar 22 (thermal)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
References: <20180322193847.63181403@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
Date: Thu, 22 Mar 2018 10:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322193847.63181403@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180321:
> 
> The vfs tree still had its build failure for which I reverted a commit.
> 

on i386:

ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!

so in drivers/thermal/thermal_sysfs.c, please add:

#include <linux/jiffies.h>


Reported-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
