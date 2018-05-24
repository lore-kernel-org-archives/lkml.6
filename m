Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970866AbeEXPLF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:11:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:18348 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970839AbeEXPLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:11:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58173451"
Date: Thu, 24 May 2018 23:10:14 +0800
From: "Liu, Changcheng" <changcheng.liu@intel.com>
To: jiangshanlai@gmail.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: define struct workqueue_struct in C file
Message-ID: <20180524151013.GA175207@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I have one confusion about workqueue_struct:
	1) Why struct workqueue_struct is defined in C file instead of
	header file?
	   I'm trying to print "workqueue_struct:name" field in one external
	   build module. "workqueue_struct:name" can't be accessed directly.

	2) struct work_struct is defined in "workqueue.h", could struct
	workqueue_struct also be defined in it?

--Thanks
Changcheng
