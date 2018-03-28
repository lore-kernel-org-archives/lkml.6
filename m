Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeC1ONm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:13:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37759 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753186AbeC1ONl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:13:41 -0400
Date: Wed, 28 Mar 2018 16:13:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nicolas Boichat <drinkcat@chromium.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        groeck@chromium.org, dtor@chromium.org,
        Haridhar Kalvala <haridhar.kalvala@intel.com>
Subject: Re: [PATCH] HID: google: Enable PM Full On mode when adjusting
 backlight
In-Reply-To: <20180328061610.206090-1-drinkcat@chromium.org>
Message-ID: <nycvar.YFH.7.76.1803281613260.15778@cbobk.fhfr.pm>
References: <20180328061610.206090-1-drinkcat@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Nicolas Boichat wrote:

> From: Haridhar Kalvala <haridhar.kalvala@intel.com>
> 
> hammer LED backlight brightness is not getting set when USB
> device is in suspend state.
> 
> This patch fixes the issue by requesting USB HID device to be
> in FULLON mode, so that sending hardware output report and
> hardware raw request won't fail to set brightness, and set
> device back to NORMAL mode once this call returns.
> 
> Signed-off-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to for-4.17/google-hammer. Thanks,

-- 
Jiri Kosina
SUSE Labs
