Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033303AbeCAROs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:14:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:24331 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032742AbeCAROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:14:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="208134251"
Date: Thu, 1 Mar 2018 10:16:44 -0700
From: Keith Busch <keith.busch@intel.com>
To: Wen Xiong <wenxiong@us.ibm.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, wenxiong <wenxiong@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] nvme-pci: Fixes EEH failure on ppc
Message-ID: <20180301171644.GD14799@localhost.localdomain>
References: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <bf3a386a2b82dac84b681c14d5334632@linux.vnet.ibm.com>
 <20180228235537.GK16002@localhost.localdomain>
 <OFB428CB19.833F7B7C-ON00258243.005E4D59-86258243.005E7EAB@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB428CB19.833F7B7C-ON00258243.005E4D59-86258243.005E7EAB@notes.na.collabserv.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:12:08AM -0600, Wen Xiong wrote:
>    Hi Keith,
> 
>    It is perfect! I go with it.

Thanks, queued up for 4.16.
