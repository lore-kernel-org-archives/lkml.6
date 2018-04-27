Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757183AbeD0BBt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:01:49 -0400
Received: from imap.thunk.org ([74.207.234.97]:36386 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754298AbeD0BBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:01:48 -0400
Date: Thu, 26 Apr 2018 21:01:24 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Shuah Khan <shuah@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 4.17.0-rc2 - WARNING: inconsistent lock state
Message-ID: <20180427010124.GI5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <2f2bd4d8-f143-913f-af5c-2767d4e35149@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2bd4d8-f143-913f-af5c-2767d4e35149@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 08:44:04AM -0600, Shuah Khan wrote:
> I am seeing the following on my system with 4.17-rc2. Probably in 4.17-rc1
> as well.
> 
> Something to be concerned about. Is this related to
> Commit: a45403b51582a87872927a3e0fc0a389c26867f1
> ext4: always initialize the crc32c checksum driver?

It should be fixed by 6c1e851c4ed: random: fix possible sleeping
allocation from irq context.

				- Ted
