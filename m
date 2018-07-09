Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B7C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B208D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B208D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeGIMbo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:31:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932568AbeGIMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:31:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1B0DAF9D;
        Mon,  9 Jul 2018 12:31:40 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:31:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hiddev: fix potential Spectre v1
In-Reply-To: <20180629220844.GA13823@embeddedor.com>
Message-ID: <nycvar.YFH.7.76.1807091431310.997@cbobk.fhfr.pm>
References: <20180629220844.GA13823@embeddedor.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018, Gustavo A. R. Silva wrote:

> uref->field_index, uref->usage_index, finfo.field_index and
> cinfo.index can be indirectly controlled by user-space, hence
> leading to a potential exploitation of the Spectre variant 1
> vulnerability.
> 
> This issue was detected with the help of Smatch:

Applied, thanks Gustavo.

-- 
Jiri Kosina
SUSE Labs

