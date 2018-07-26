Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA84420883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA84420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeGZLIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:08:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:13793 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbeGZLIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:08:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 02:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="59963443"
Received: from hu.sh.intel.com ([10.239.160.33])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2018 02:52:09 -0700
From:   Chen Hu <hu1.chen@intel.com>
To:     andy.shevchenko@gmail.com
Cc:     Chen Hu <hu1.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
Date:   Thu, 26 Jul 2018 17:36:20 +0800
Message-Id: <20180726093620.3876-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
References: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,
Thanks the feedback.

Is it better to modify the DesignWare 8250 driver directly? Or do you think is this really an issue?

Thanks
Chen Hu
