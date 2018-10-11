Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79775C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3295820658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3295820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJLDce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:32:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbeJLDce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:32:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2A70ACEA;
        Thu, 11 Oct 2018 20:03:44 +0000 (UTC)
Date:   Thu, 11 Oct 2018 22:03:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur
 2
In-Reply-To: <20181011075633.18868-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1810112203350.14430@cbobk.fhfr.pm>
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018, Kai-Heng Feng wrote:

> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
> do not increment usages when a duplicate is found").
> 
> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
> can solve the issue.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
> BugLink: https://bugs.launchpad.net/bugs/1793846
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

