Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCWNzj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:55:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbeCWNzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:55:37 -0400
Date: Fri, 23 Mar 2018 14:55:36 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID core and multitouch fixups
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1803231455220.15778@cbobk.fhfr.pm>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Benjamin Tissoires wrote:

> Patches 1 and 2 are related to the Razer Blade Stealth that has some dead zone
> near the edges of the touchpad.
> Patches 3 was previously sent and reviewed by Dmitry and he suggested patch 4
> at the time.
> Patches 5..7 are cleanups I realized while trying to merge hid-multitouch
> into hid-core, so that other drivers could reuse the hid-mt logic (but it's
> not that easy I must confess).

I've split this into two logical sets, and applied. Thanks!

-- 
Jiri Kosina
SUSE Labs
