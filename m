Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDLNGs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:06:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58859 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752652AbeDLNGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:06:46 -0400
Date: Thu, 12 Apr 2018 15:06:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Fix resume issue on Raydium touchscreen
 device
In-Reply-To: <1523259691-7672-1-git-send-email-aaron.ma@canonical.com>
Message-ID: <nycvar.YFH.7.76.1804121506360.28129@cbobk.fhfr.pm>
References: <1523259691-7672-1-git-send-email-aaron.ma@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Aaron Ma wrote:

> When Rayd touchscreen resumed from S3, it issues too many errors like:
> i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)
> 
> And all the report data are corrupted, touchscreen is unresponsive.
> 
> Fix this by re-sending report description command after resume.
> Add device ID as a quirk.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
