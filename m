Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3720C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C5020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C5020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbeLELs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:48:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:35614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLELs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:48:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AB80AF43;
        Wed,  5 Dec 2018 11:48:55 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        akshay.adiga@linux.vnet.ibm.com,
        Bharath Thodla <bharath.thodla@in.ibm.com>
Subject: Re: [PATCH] cpupower : Auto-completion for cpupower tool
Date:   Wed, 05 Dec 2018 12:48:53 +0100
Message-ID: <2133486.u21R1XiQqC@house>
In-Reply-To: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
References: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 5, 2018 12:31:04 PM CET Abhishek Goel wrote:
> This script adds support for auto-completion for cpupower tool.
> Added support for auto-completion of all the eight commands for
> cpupower tool and their all subsequent sub-commands, wherever
> possible.

From what I see all changes I proposed in a previous review round
with a "not that broad audience" have been addressed.

I already integrated the patch (slightly different, without functional 
changes) into the latest cpupower sources of our build service and
things work out nice.

Shuah: Can you pick this up for next cpupower submission round, please.

Thanks,

       Thomas
