Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeD2RFs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 13:05:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33942 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeD2RFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 13:05:46 -0400
X-Google-Smtp-Source: AB8JxZpqkIOVKxJOZFAb9inDX+uuxE9IjG8XBkzUaspGkLZz3haOZl2a/j2sPKEehcvRFI2dl9bnUw==
Date: Sun, 29 Apr 2018 10:05:41 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429170541.lrzwyihrd6d75rql@sultan-box>
References: <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429143205.GD13475@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 04:32:05PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is why ultimately, we do need to attack this problem from both
> > ends, which means teaching userspace programs to only request
> > cryptographic-grade randomness when it is really needed --- and most
> > of the time, if the user has not logged in yet, you probably don't
> > need cryptographic-grade randomness....
> 
> IOW moving them from /dev/random to /dev/urandom?
> 								Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

/dev/urandom isn't cryptographically secure, so that's not an option.
