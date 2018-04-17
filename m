Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDQL6i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752655AbeDQL6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:58:37 -0400
Date: Tue, 17 Apr 2018 13:58:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Robert Munteanu <rombert@apache.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v6] Fix modifier keys for Redragon Asura Keyboard
In-Reply-To: <20180416213824.14688-1-rombert@apache.org>
Message-ID: <nycvar.YFH.7.76.1804171358270.28129@cbobk.fhfr.pm>
References: <20180416213824.14688-1-rombert@apache.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Robert Munteanu wrote:

> This adds a new driver for the Redragon Asura keyboard. The Asura
> keyboard contains an error in the HID descriptor which causes all
> modifier keys to be mapped to left shift. Additionally, we suppress
> the creation of a second, not working, keyboard device.
> 
> Signed-off-by: Robert Munteanu <rombert@apache.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
