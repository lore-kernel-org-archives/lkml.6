Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165532145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeIXPXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:23:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727482AbeIXPXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:23:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A061AAE47;
        Mon, 24 Sep 2018 09:21:59 +0000 (UTC)
Date:   Mon, 24 Sep 2018 11:21:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] HID: intel ISH: Cleanup patches
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1809241121470.15880@cbobk.fhfr.pm>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Srinivas Pandruvada wrote:

> This series is a cleanup series only and help to abstract client API.
> 
> There are no functional changes.
> 
> Even Xu (6):
>   hid: intel-ish-hid: ishtp: add helper function for driver data get/set
>   hid: intel-ish-hid: use helper function for private driver data
>     set/get
>   hid: intel-ish-hid: ishtp: add helper functions for client buffer
>     operation
>   hid: intel-ish-hid: use helper function to access client buffer
>   hid: intel-ish-hid: ishtp: add helper function for client search
>   hid: intel-ish-hid: use helper function to search client id
> 
> Hong Liu (2):
>   HID: intel-ish-hid: use resource-managed api
>   HID: intel-ish-hid: using list_head for ipc write queue
> 
> Srinivas Pandruvada (1):
>   HID: intel_ish-hid: Enhance API to get ring buffer sizes

Applied to for-4.20/ish.

-- 
Jiri Kosina
SUSE Labs

