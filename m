Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeCMEZ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 00:25:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750903AbeCMEZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 00:25:57 -0400
Date: Tue, 13 Mar 2018 00:21:15 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak21 V2 2/4] audit: link denied should not directly
 generate PATH record
Message-ID: <20180313042115.zcyxhijg3d4yvvch@madcap2.tricolour.ca>
References: <9ed76ccb239078ad5a2808d23c7b7f1738b0b2b8.1520835596.git.rgb@redhat.com>
 <201803130221.QotEZsdF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803130221.QotEZsdF%fengguang.wu@intel.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-13 02:22, kbuild test robot wrote:
> Hi Richard,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc5 next-20180309]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

My fault.  It was applied to a stale tree:
	git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git

A self-NACKed patch wasn't removed from the upstream tree as hoped.  A
new patch is already in the works.

> url:    https://github.com/0day-ci/linux/commits/Richard-Guy-Briggs/audit-address-ANOM_LINK-excess-records/20180313-015527
> Note: the linux-review/Richard-Guy-Briggs/audit-address-ANOM_LINK-excess-records/20180313-015527 HEAD 12e8c56bcd359f7d20d4ae011674d37bc832bc4c builds fine.
>       It only hurts bisectibility.

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
