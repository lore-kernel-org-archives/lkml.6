Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCIBDV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:03:21 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34115 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeCIBDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:03:19 -0500
X-Google-Smtp-Source: AG47ELvmBXWGWSW6AeB4hPujEVHiFnLRWX+yQS1g7oFKvqeVXibKahxUotaVmpiLZ4m81X5e67SzjQ==
Date: Thu, 8 Mar 2018 19:03:09 -0600
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: TSCS42xx: make const array norm_addrs static,
 reduces object code size
Message-ID: <20180309010308.GA19046@t7-ThinkPad-E560>
References: <20180214172153.5749-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214172153.5749-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:21:53PM +0000, Colin King wrote:

> Don't populate the const array norm_addrs on the stack, instead make it
> static.  Makes the object code smaller by over 230 bytes.  Also re-format
> array data as the insertion of the static keywork made the first line
> overly long.

I have tested this on our HAT and it works well. You can add:

Reviewed-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Tested-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>

Regards,

Steven
