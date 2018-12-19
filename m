Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969ECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F520874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeLSTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:39:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:48814 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeLSTjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:39:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 11:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="119765434"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2018 11:39:32 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F2B36300B49; Wed, 19 Dec 2018 11:39:31 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:39:31 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, igor.stoppa@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
Message-ID: <20181219193931.GV25620@tassilo.jf.intel.com>
References: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
 <20181219185544.6720-1-igor.stoppa@huawei.com>
 <ad8b075efc39ef10727b118ed292f3353311c6db.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8b075efc39ef10727b118ed292f3353311c6db.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 				     "expecting a 'help' section of $min_conf_desc_length or more lines\n" . $herecurr);
> or maybe
> 				     "please write a paragraph that describes the config symbol fully ($min_conf_desc_length or more lines)\n" . $herecurr);
> 
> Andi?
> You are the originator of this text.
> Do you have an opinion?

Either change is fine for me.

-Andi

> 
> 
