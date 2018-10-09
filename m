Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CFAC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C103214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C103214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJJHJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:09:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:48752 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeJJHJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:09:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 16:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,362,1534834800"; 
   d="gz'50?scan'50,208,50";a="264321165"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2018 16:49:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gA1l1-0002lW-Jf; Wed, 10 Oct 2018 07:49:43 +0800
Date:   Wed, 10 Oct 2018 07:48:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Bjorn Helgaas <helgaas@kernel.org>
Subject: [tip:x86/mm 4/4] htmldocs: kernel/resource.c:337: warning: Function
 parameter or member 'first_lvl' not described in 'find_next_iomem_res'
Message-ID: <201810100742.5gkURC2U%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
head:   b69c2e20f6e4046da84ce5b33ba1ef89cb087b40
commit: b69c2e20f6e4046da84ce5b33ba1ef89cb087b40 [4/4] resource: Clean it up a bit
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   kernel/resource.c:337: warning: Function parameter or member 'start' not described in 'find_next_iomem_res'
   kernel/resource.c:337: warning: Function parameter or member 'end' not described in 'find_next_iomem_res'
   kernel/resource.c:337: warning: Function parameter or member 'flags' not described in 'find_next_iomem_res'
   kernel/resource.c:337: warning: Function parameter or member 'desc' not described in 'find_next_iomem_res'
>> kernel/resource.c:337: warning: Function parameter or member 'first_lvl' not described in 'find_next_iomem_res'
   kernel/resource.c:337: warning: Function parameter or member 'res' not described in 'find_next_iomem_res'
>> kernel/resource.c:409: warning: Function parameter or member 'arg' not described in 'walk_iomem_res_desc'
>> kernel/resource.c:409: warning: Function parameter or member 'func' not described in 'walk_iomem_res_desc'
>> kernel/resource.c:409: warning: Function parameter or member 'arg' not described in 'walk_iomem_res_desc'
>> kernel/resource.c:409: warning: Function parameter or member 'func' not described in 'walk_iomem_res_desc'
   include/linux/srcu.h:175: warning: Function parameter or member 'p' not described in 'srcu_dereference_notrace'
   include/linux/srcu.h:175: warning: Function parameter or member 'sp' not described in 'srcu_dereference_notrace'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'

vim +337 kernel/resource.c

^1da177e4 Linus Torvalds    2005-04-16  320  
010a93bf9 Bjorn Helgaas     2018-09-27  321  /**
010a93bf9 Bjorn Helgaas     2018-09-27  322   * Finds the lowest iomem resource that covers part of [start..end].  The
010a93bf9 Bjorn Helgaas     2018-09-27  323   * caller must specify start, end, flags, and desc (which may be
010a93bf9 Bjorn Helgaas     2018-09-27  324   * IORES_DESC_NONE).
010a93bf9 Bjorn Helgaas     2018-09-27  325   *
010a93bf9 Bjorn Helgaas     2018-09-27  326   * If a resource is found, returns 0 and *res is overwritten with the part
010a93bf9 Bjorn Helgaas     2018-09-27  327   * of the resource that's within [start..end]; if none is found, returns
010a93bf9 Bjorn Helgaas     2018-09-27  328   * -1.
010a93bf9 Bjorn Helgaas     2018-09-27  329   *
010a93bf9 Bjorn Helgaas     2018-09-27  330   * This function walks the whole tree and not just first level children
b69c2e20f Borislav Petkov   2018-10-09  331   * unless @first_lvl is true.
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  332   */
010a93bf9 Bjorn Helgaas     2018-09-27  333  static int find_next_iomem_res(resource_size_t start, resource_size_t end,
010a93bf9 Bjorn Helgaas     2018-09-27  334  			       unsigned long flags, unsigned long desc,
b69c2e20f Borislav Petkov   2018-10-09  335  			       bool first_lvl, struct resource *res)
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  336  {
2842f1141 KAMEZAWA Hiroyuki 2006-06-27 @337  	struct resource *p;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  338  
b69c2e20f Borislav Petkov   2018-10-09  339  	if (!res)
b69c2e20f Borislav Petkov   2018-10-09  340  		return -EINVAL;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  341  
b69c2e20f Borislav Petkov   2018-10-09  342  	if (start >= end)
b69c2e20f Borislav Petkov   2018-10-09  343  		return -EINVAL;
8c86e70ac Vivek Goyal       2014-08-08  344  
800df627e Vivek Goyal       2014-08-29  345  	read_lock(&resource_lock);
800df627e Vivek Goyal       2014-08-29  346  
b69c2e20f Borislav Petkov   2018-10-09  347  	for (p = iomem_resource.child; p; p = next_resource(p, first_lvl)) {
010a93bf9 Bjorn Helgaas     2018-09-27  348  		if ((p->flags & flags) != flags)
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  349  			continue;
3f33647c4 Toshi Kani        2016-01-26  350  		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
3f33647c4 Toshi Kani        2016-01-26  351  			continue;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  352  		if (p->start > end) {
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  353  			p = NULL;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  354  			break;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  355  		}
a98959fdb Bjorn Helgaas     2018-09-27  356  		if ((p->end >= start) && (p->start <= end))
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  357  			break;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  358  	}
8c86e70ac Vivek Goyal       2014-08-08  359  
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  360  	read_unlock(&resource_lock);
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  361  	if (!p)
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  362  		return -1;
010a93bf9 Bjorn Helgaas     2018-09-27  363  
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  364  	/* copy data */
010a93bf9 Bjorn Helgaas     2018-09-27  365  	res->start = max(start, p->start);
010a93bf9 Bjorn Helgaas     2018-09-27  366  	res->end = min(end, p->end);
0e4c12b45 Tom Lendacky      2017-10-20  367  	res->flags = p->flags;
0e4c12b45 Tom Lendacky      2017-10-20  368  	res->desc = p->desc;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  369  	return 0;
2842f1141 KAMEZAWA Hiroyuki 2006-06-27  370  }
908eedc61 KAMEZAWA Hiroyuki 2009-09-22  371  
010a93bf9 Bjorn Helgaas     2018-09-27  372  static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
010a93bf9 Bjorn Helgaas     2018-09-27  373  				 unsigned long flags, unsigned long desc,
b69c2e20f Borislav Petkov   2018-10-09  374  				 bool first_lvl, void *arg,
1d2e733b1 Tom Lendacky      2017-10-20  375  				 int (*func)(struct resource *, void *))
4ac2aed83 Tom Lendacky      2017-10-20  376  {
010a93bf9 Bjorn Helgaas     2018-09-27  377  	struct resource res;
4ac2aed83 Tom Lendacky      2017-10-20  378  	int ret = -1;
4ac2aed83 Tom Lendacky      2017-10-20  379  
010a93bf9 Bjorn Helgaas     2018-09-27  380  	while (start < end &&
b69c2e20f Borislav Petkov   2018-10-09  381  	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
010a93bf9 Bjorn Helgaas     2018-09-27  382  		ret = (*func)(&res, arg);
4ac2aed83 Tom Lendacky      2017-10-20  383  		if (ret)
4ac2aed83 Tom Lendacky      2017-10-20  384  			break;
4ac2aed83 Tom Lendacky      2017-10-20  385  
010a93bf9 Bjorn Helgaas     2018-09-27  386  		start = res.end + 1;
4ac2aed83 Tom Lendacky      2017-10-20  387  	}
4ac2aed83 Tom Lendacky      2017-10-20  388  
4ac2aed83 Tom Lendacky      2017-10-20  389  	return ret;
4ac2aed83 Tom Lendacky      2017-10-20  390  }
4ac2aed83 Tom Lendacky      2017-10-20  391  
b69c2e20f Borislav Petkov   2018-10-09  392  /**
8c86e70ac Vivek Goyal       2014-08-08  393   * Walks through iomem resources and calls func() with matching resource
8c86e70ac Vivek Goyal       2014-08-08  394   * ranges. This walks through whole tree and not just first level children.
8c86e70ac Vivek Goyal       2014-08-08  395   * All the memory ranges which overlap start,end and also match flags and
3f33647c4 Toshi Kani        2016-01-26  396   * desc are valid candidates.
3f33647c4 Toshi Kani        2016-01-26  397   *
3f33647c4 Toshi Kani        2016-01-26  398   * @desc: I/O resource descriptor. Use IORES_DESC_NONE to skip @desc check.
3f33647c4 Toshi Kani        2016-01-26  399   * @flags: I/O resource flags
3f33647c4 Toshi Kani        2016-01-26  400   * @start: start addr
3f33647c4 Toshi Kani        2016-01-26  401   * @end: end addr
3f33647c4 Toshi Kani        2016-01-26  402   *
3f33647c4 Toshi Kani        2016-01-26  403   * NOTE: For a new descriptor search, define a new IORES_DESC in
3f33647c4 Toshi Kani        2016-01-26  404   * <linux/ioport.h> and set it in 'desc' of a target resource entry.
3f33647c4 Toshi Kani        2016-01-26  405   */
3f33647c4 Toshi Kani        2016-01-26  406  int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
1d2e733b1 Tom Lendacky      2017-10-20  407  		u64 end, void *arg, int (*func)(struct resource *, void *))
3f33647c4 Toshi Kani        2016-01-26  408  {
010a93bf9 Bjorn Helgaas     2018-09-27 @409  	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
3f33647c4 Toshi Kani        2016-01-26  410  }
d76401ade Dan Williams      2018-06-02  411  EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
3f33647c4 Toshi Kani        2016-01-26  412  

:::::: The code at line 337 was first introduced by commit
:::::: 2842f11419704f8707fffc82e10d2263427fc130 [PATCH] catch valid mem range at onlining memory

:::::: TO: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--n8g4imXOkfNTN/H1--
