Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84727C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CA820891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CA820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934933AbeFLXsv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:48:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:7889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934383AbeFLXst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:48:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 16:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="236649895"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.61])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2018 16:48:47 -0700
Date:   Wed, 13 Jun 2018 07:37:38 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v6 00/29] FPGA Device Feature List (DFL) Device Drivers
Message-ID: <20180612233738.GA8459@hao-dev>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <CANk1AXSPd10twvT0tXKBxb9Cc2bK_TrVdZ6gnLKkB_ujCcD8wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSPd10twvT0tXKBxb9Cc2bK_TrVdZ6gnLKkB_ujCcD8wQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:33:42PM -0500, Alan Tull wrote:
> On Tue, Jun 12, 2018 at 5:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> > Hi All,
> >
> > Here is v6 patch-series adding drivers for FPGA DFL devices.
> 
> I pushed this patchset to a branch on my linux-fpga kernel.org git
> repo for the robots to test.

Hi Alan

Thanks a lot for review, will update target kernel version to 4.19 in sysfs
documentation, fix Kconfig description per comments from Randy and also one
improvement reported by kbuild in v7.

Thanks
Hao

> 
> Alan
> 
> >
> > This patch series provides a common framework to support FPGA Device Feature
> > List (DFL), and also feature dev drivers under this DFL framework to provide
> > interfaces for userspace applications to configure, enumerate, open, and
> > access FPGA accelerators on DFL based FPGA device and enables system level
> > management functions such as FPGA partial reconfiguration, power management
> > and virtualization.
