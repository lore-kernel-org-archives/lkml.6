Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17378C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D320660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANIjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:39:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:25543 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfANIjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:39:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 00:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="109682226"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.11.138]) ([10.102.11.138])
  by orsmga008.jf.intel.com with ESMTP; 14 Jan 2019 00:39:41 -0800
Subject: Re: [PATCH] drivers/md.c: Make bio_alloc_mddev return
 bio_alloc_bioset
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     shli@kernel.org, linux-raid@vger.kernel.org
References: <20181222100845.566772-1-marcos.souza.org@gmail.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <88ac62d2-3f31-fbe4-4463-ff9d23b5e200@intel.com>
Date:   Mon, 14 Jan 2019 09:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181222100845.566772-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/18 11:08 AM, Marcos Paulo de Souza wrote:
> bio_alloc_bioset return a bio pointer or NULL, so we can avoid storing
> the returned data into a new variable.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
