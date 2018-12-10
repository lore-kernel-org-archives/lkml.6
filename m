Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D892084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D892084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeLJSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:38:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:50049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeLJSiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:38:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 10:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="282469086"
Received: from anambiar-mobl1.amr.corp.intel.com (HELO [10.252.192.151]) ([10.252.192.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2018 10:38:24 -0800
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        aul Blakey <paulb@mellanox.com>
References: <20181210123633.4a0e4409@canb.auug.org.au>
From:   "Nambiar, Amritha" <amritha.nambiar@intel.com>
Message-ID: <35edf438-0a07-83e3-be6d-5989007b683a@intel.com>
Date:   Mon, 10 Dec 2018 10:38:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210123633.4a0e4409@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/2018 5:36 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   net/sched/cls_flower.c
> 
> between commit:
> 
>   35cc3cefc4de ("net/sched: cls_flower: Reject duplicated rules also under skip_sw")
> 
> from the net tree and commit:
> 
>   5c72299fba9d ("net: sched: cls_flower: Classify packets using port ranges")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Looks good to me. Thanks!
