Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1727520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1727520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeILOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:14:28 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43440 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeILOO1 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 12 Sep 2018 10:14:27 -0400
Received: from linux-9avr.suse (prg-ext-pat.suse.com [213.151.95.130])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 12 Sep 2018 11:10:49 +0200
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        bpetkov@suse.de, linux-kernel@vger.kernel.org
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
From:   James Wang <jnwang@suse.com>
Openpgp: preference=signencrypt
Organization: QA-SLE
Message-ID: <14f8bb1c-ef13-1329-b144-d487949615e5@suse.com>
Date:   Wed, 12 Sep 2018 17:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 02:41 PM, Pingfan Liu wrote:
> Cc James, could you try to enable initcall_debug, and paste the
> shutdown seq with 722e5f2b1eec ("driver core: Partially revert "driver
> core: correct device's shutdown order"") and without it?
OK. And I will scheudule some testing orders, ahah, I'm in a business trip.
All operations will be a little bit delay, but I will make it done.

James 

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

