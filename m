Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeEOJQI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:16:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53699 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbeEOJQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:16:05 -0400
Date: Tue, 15 May 2018 11:16:03 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dtor@google.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] HID: i2c-hid: check if device is there before really
 probing
In-Reply-To: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Message-ID: <nycvar.YFH.7.76.1805151115540.27054@cbobk.fhfr.pm>
References: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018, Dmitry Torokhov wrote:

> From: Dmitry Torokhov <dtor@chromium.org>
> 
> On many Chromebooks touch devices are multi-sourced; the components are
> electrically compatible and one can be freely swapped for another without
> changing the OS image or firmware.
> 
> To avoid bunch of scary messages when device is not actually present in the
> system let's try testing basic communication with it and if there is no
> response terminate probe early with -ENXIO.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
