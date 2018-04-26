Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeDZFBE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:01:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:60278 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeDZFA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:00:58 -0400
Date: Thu, 26 Apr 2018 01:00:56 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426050056.GF18803@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 09:11:08PM -0700, Sultan Alsawaf wrote:
> I noticed "systems without sufficient boot randomness" and would like to add to this.
> 
> With the changes to /dev/random going from 4.16.3 to 4.16.4, my low-spec Chromebook does not reach
> the login screen upon boot (it stays stuck on a black screen) until I provide a source of entropy to
> the system via interrupts (e.g., holding down a key on the keyboard for 5 sec or moving my finger
> across the touchpad a lot). After providing a source of entropy for long enough,
> "random: crng init done" prints out in dmesg and the login screen finally pops up.

Thanks for the report!

I assume since you're upgrading your own kernel, you must not be
running Chrome OS on your Acer CB3-431 Chromebook (Edgar).  Are you
running Chromium --- or some Linux distribution on it?

Thanks,

					- Ted
