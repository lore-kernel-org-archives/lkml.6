Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967139AbeBPMjK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:50691 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:39:08 -0500
Date: Fri, 16 Feb 2018 13:39:06 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aaron Bottegal <aaronbottegal@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] HID: corsair: Add K70 Vengeance and K70 RAPIDFIRE
 to
In-Reply-To: <20171222083814.9090-1-aaronbottegal@gmail.com>
Message-ID: <nycvar.YFH.7.76.1802161338550.13621@cbobk.fhfr.pm>
References: <20171222083814.9090-1-aaronbottegal@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2017, Aaron Bottegal wrote:

> K70 Vengeance sends garbage keypresses when changing  backlight brightness.
> This hooks to the existing corsair driver, which filters out those
> invalid keypresses on similar devices in the input mapping code.

Applied to for-4.16/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
