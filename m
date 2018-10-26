Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62974C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7BC2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7BC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJ0AFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbeJ0AFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:05:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96DE0AC9F;
        Fri, 26 Oct 2018 15:27:42 +0000 (UTC)
Date:   Fri, 26 Oct 2018 17:27:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: alps: allow incoming reports when only the trackstick
 is opened
In-Reply-To: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1810261727320.23511@cbobk.fhfr.pm>
References: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Benjamin Tissoires wrote:

> If userspace only reads the trackstick node, and no one is listening to
> the touchpad nor the hidraw node then, the device is not powered on.
> 
> Add open/close callbacks to allow users to disable the touchpad in Gnome
> while keeping the trackstick active.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1559632
> Link: https://gitlab.gnome.org/GNOME/mutter/issues/128
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

