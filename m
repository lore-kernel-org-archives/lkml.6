Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeDPJt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:49:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbeDPJt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:49:56 -0400
Date: Mon, 16 Apr 2018 11:49:54 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Robert Munteanu <rombert@apache.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
In-Reply-To: <20180411094953.12053-1-rombert@apache.org>
Message-ID: <nycvar.YFH.7.76.1804161148370.28129@cbobk.fhfr.pm>
References: <20180411094953.12053-1-rombert@apache.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, Robert Munteanu wrote:

> Changelog:
> 
> - v2: modifier keys work, some combinations are still troublesome
> - v3: style cleanup, rebase on top of 4.14
> - v4: remove most debugging calls, make init info useful for user,
>   rebased on top of 4.15
> - v5: fix the HID descriptor as suggested by Benjamin Tissoires,
>   use existing USB vendor id, update comment style, add SPDX
>   license identifier, rename to hid-redragon, stop registering
>   two input devices, rebased on top of 4.16

This should contain the text that goes directly into the git commit 
changelog, therefore should instead contain something like "This adds a 
news driver for HW XX, that needs a specialized driver bacuse .... and 
things to specifically point out in implementation are ....".

Could you please provide that, so that I can commit it?

Thanks.

-- 
Jiri Kosina
SUSE Labs
