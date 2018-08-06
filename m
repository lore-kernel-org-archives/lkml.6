Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638ADC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2958E21991
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2958E21991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeHFPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:18:08 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42787 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHFPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:18:07 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C004C80377;
        Mon,  6 Aug 2018 15:09:03 +0200 (CEST)
Date:   Mon, 6 Aug 2018 15:09:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sparc32: split ramdisk detection and reservation
 to a helper function
Message-ID: <20180806130902.GB23652@ravnborg.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533552755-16679-4-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=VnNF1IyMAAAA:8 a=7gkXJVJtAAAA:8
        a=pj4DBPmF0T3MQ-UG1EYA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:52:35PM +0300, Mike Rapoport wrote:
> The detection and reservation of ramdisk memory were separated to allow
> bootmem bitmap initialization after the ramdisk boundaries are detected.
> Since the bootmem initialization is removed, the reservation of ramdisk
> memory is done immediately after its boundaries are found.
> 
> Split the entire block into a separate helper function.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

