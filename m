Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030793AbeEYXO3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 19:14:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbeEYXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 19:14:27 -0400
Subject: Re: mmotm 2018-05-25-14-52 uploaded
 (drivers/net/ethernet/ti/davinci_mdio.c)
To: akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20180525215254.VTc61%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Cc: Anant Gole <anantgole@ti.com>, Chaithrika U S <chaithrika@ti.com>
Message-ID: <26483e60-ab26-494c-b923-86c267cfdac0@infradead.org>
Date: Fri, 25 May 2018 16:14:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525215254.VTc61%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 02:52 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-05-25-14-52 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

on x86_64:
# CONFIG_OF is not set

  CC      drivers/net/ethernet/ti/davinci_cpdma.o
../drivers/net/ethernet/ti/davinci_mdio.c: In function 'davinci_mdio_probe':
../drivers/net/ethernet/ti/davinci_mdio.c:380:3: error: implicit declaration of function 'davinci_mdio_probe_dt' [-Werror=implicit-function-declaration]
   ret = davinci_mdio_probe_dt(&data->pdata, pdev);



> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> A git tree which contains the memory management portion of this tree is
> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
> by Michal Hocko.  It contains the patches which are between the
> "#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
> file, http://www.ozlabs.org/~akpm/mmotm/series.
> 
> 
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
> 
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/
> 
> To develop on top of mmotm git:
> 
>   $ git remote add mmotm git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>   $ git remote update mmotm
>   $ git checkout -b topic mmotm/master
>   <make changes, commit>
>   $ git send-email mmotm/master.. [...]
> 
> To rebase a branch with older patches to a new mmotm release:
> 
>   $ git remote update mmotm
>   $ git rebase --onto mmotm/master <topic base> topic
> 
> 
> 
> 
> The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
> 
> A git copy of this tree is available at
> 
> 	http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/
> 
> and use of this tree is similar to
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.
> 
> 
> This mmotm tree contains the following patches against 4.17-rc6:
> (patches marked "*" will be included in linux-next)
> 


-- 
~Randy
