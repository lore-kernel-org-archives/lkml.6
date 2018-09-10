Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18DEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42A22086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42A22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeIJTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:55:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:13198 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbeIJTzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:55:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 08:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="79343216"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2018 08:00:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzNgQ-0002nJ-8e; Mon, 10 Sep 2018 23:00:58 +0800
Date:   Mon, 10 Sep 2018 23:00:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     kbuild-all@01.org, David Sterba <dsterba@suse.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <jbacik@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 3022/3360] fs/btrfs/extent-tree.c:2540:5: sparse:
 symbol 'btrfs_run_delayed_refs_for_head' was not declared. Should it be
 static?
Message-ID: <201809102215.95hxOLVe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   43783a8f68478e81fe183f86162d3e7ca29ba923
commit: ac75a14eb672441d674d46b64a03f59d0f186cae [3022/3360] btrfs: Factor out loop processing all refs of a head
reproduce:
        # apt-get install sparse
        git checkout ac75a14eb672441d674d46b64a03f59d0f186cae
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/btrfs/extent-tree.c:273:39: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:273:39: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:397:16: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:2506:31: sparse: symbol 'btrfs_obtain_ref_head' was not declared. Should it be static?
>> fs/btrfs/extent-tree.c:2540:5: sparse: symbol 'btrfs_run_delayed_refs_for_head' was not declared. Should it be static?
   fs/btrfs/extent-tree.c:4439:26: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4789:31: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4789:31: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4984:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4984:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4984:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:4984:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5001:22: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5553:48: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5553:48: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5795:21: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5800:27: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5806:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:5806:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6196:29: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6196:29: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6617:23: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6617:23: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6620:31: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6620:31: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6663:42: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:6663:42: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7382:24: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7382:24: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7383:24: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7383:24: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7547:43: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7547:43: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7892:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7892:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7895:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:7895:37: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:8446:35: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:8449:35: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:8449:35: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:10961:25: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:10961:25: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:10962:23: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:10962:23: sparse: expression using sizeof(void)
   fs/btrfs/extent-tree.c:2419:20: sparse: context imbalance in 'cleanup_extent_op' - unexpected unlock
   fs/btrfs/extent-tree.c:2452:28: sparse: context imbalance in 'cleanup_ref_head' - unexpected unlock
>> fs/btrfs/extent-tree.c:2557:36: sparse: context imbalance in 'btrfs_run_delayed_refs_for_head' - unexpected unlock
   fs/btrfs/extent-tree.c:2664:26: sparse: context imbalance in '__btrfs_run_delayed_refs' - different lock contexts for basic block
   fs/btrfs/extent-tree.c:7249:39: sparse: context imbalance in 'btrfs_lock_cluster' - wrong count at exit
   fs/btrfs/extent-tree.c:7526:44: sparse: context imbalance in 'find_free_extent' - unexpected unlock
   fs/btrfs/extent-tree.c:9712:9: sparse: context imbalance in 'btrfs_put_block_group_cache' - wrong count at exit

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
