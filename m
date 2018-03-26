Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeCZVFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:05:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41055 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCZVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:05:30 -0400
X-Google-Smtp-Source: AIpwx49g4b+Rw3akloMQWWk+MGQOBt0m1ESe/o2Rvt3VTb8xnG8W29E3Cfj7roeJjKNakDRmvqCa4g==
Date: Mon, 26 Mar 2018 14:05:27 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: linux-next: Tree for Mar 22 (thermal)
Message-ID: <20180326210524.GB1899@localhost.localdomain>
References: <20180322193847.63181403@canb.auug.org.au>
 <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui,

On Thu, Mar 22, 2018 at 10:36:38AM -0700, Randy Dunlap wrote:
> On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180321:
> > 
> > The vfs tree still had its build failure for which I reverted a commit.
> > 
> 
> on i386:
> 
> ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> 
> so in drivers/thermal/thermal_sysfs.c, please add:
> 
> #include <linux/jiffies.h>
> 
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Are you taking care of this?

> 
> thanks,
> -- 
> ~Randy
