Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeBACvz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 21:51:55 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:48063 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeBACvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 21:51:54 -0500
Subject: Re: mmotm 2018-01-31-16-51 uploaded (f2fs)
To: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, mhocko@suse.cz,
        broonie@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <5a7264b1.mqPv/eshq6wqQFu6%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b764819a-a7d6-6976-bc46-eab972566309@infradead.org>
Date: Wed, 31 Jan 2018 18:51:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5a7264b1.mqPv/eshq6wqQFu6%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 04:52 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-01-31-16-51 has been uploaded to
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
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

It looks like this build error is not from an mmotm patch but from mainline
or linux-next:

on i386:
../fs/f2fs/super.c: In function 'f2fs_fill_super':
../fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPWB' undeclared (first use in this function)
  sb->s_iflags |= SB_I_CGROUPWB;
                  ^

Anyway, it's an unknown value.

-- 
~Randy
