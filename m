Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E021C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38303218F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38303218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHFPRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:17:45 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43575 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHFPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:17:44 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B668E2003F;
        Mon,  6 Aug 2018 15:08:40 +0200 (CEST)
Date:   Mon, 6 Aug 2018 15:08:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sparc32: switch to NO_BOOTMEM
Message-ID: <20180806130839.GA23652@ravnborg.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533552755-16679-3-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533552755-16679-3-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=VnNF1IyMAAAA:8 a=7gkXJVJtAAAA:8
        a=dmwtmGJernOQ78WvcZ4A:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:52:34PM +0300, Mike Rapoport wrote:
> Each populated sparc_phys_bank is added to memblock.memory. The
> reserve_bootmem() calls are replaced with memblock_reserve(), and the
> bootmem bitmap initialization is droppped.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
