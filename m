Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3906C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A123C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A123C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeGSSdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:33:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:55311 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbeGSSde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:33:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 10:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="55639074"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jul 2018 10:48:30 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fgD2T-000KzV-0H; Fri, 20 Jul 2018 01:48:29 +0800
Date:   Fri, 20 Jul 2018 01:48:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc:     kbuild-all@01.org, tiwai@suse.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ALSA: usb-audio: AudioStreaming Power Domain parsing
Message-ID: <201807200103.6g4nrbJl%fengguang.wu@intel.com>
References: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jorge-Sanjuan/usb-audio-Add-UAC3-Power-Domains/20180719-212009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/usb/stream.c:562:5: sparse: symbol 'snd_usb_add_audio_stream_v3' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
