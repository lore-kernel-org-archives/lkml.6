Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeBRPeh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 10:34:37 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35481 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeBRPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 10:34:36 -0500
X-Google-Smtp-Source: AH8x225MEHmpGgsBRFEjuPNzBGc2ORTbIe2kg015Zh/leDSfRYEYiusV+w93RoRPx790RXIDzeMEBQ==
From: David Frey <dpfrey@gmail.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Seeking guidance on spelling fixes
Date: Sun, 18 Feb 2018 07:34:33 -0800
Message-ID: <7912182.YNFVRYok70@roach>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a common spelling mistake in some Linux kernel code that I was
reading the other day and it made me wonder how prevalent common spelling
mistakes are in the kernel.  I did some grepping and it seems that there
are a large number of spelling mistakes.  I did a bit of searching and I
found (http://www.kegel.com/kerspell/) which includes some comments/tools
relating to spelling and the Linux kernel.

I have gone ahead and corrected about 100 total instances based on 25
common misspellings.  There are many, many more common misspellings that I
could check, but I don't want to sink more time into this if the changes
won't be accepted.

Is this type of change likely to be accepted?  Right now I am making
individual git commits for each correction.  For example "aditional ->
additional".  I figured that it would be easier to review the list of
replacements rather than a mega-patch which fixes many different errors.
This way if any of the changes are controversial, I can easily rebase them
out.

I am trying to only correct true misspellings.  I'm not trying to choose
the "most correct" spelling for cases where there are acceptable alternate
spellings.

I've pushed the changes I have made so far to a "spelling_fixes" branch
here: https://github.com/dpfrey/linux/commits/spelling_fixes just in case
there is any question about what I am doing based on the above description.

Just to be clear, I'm not trying to get this portion of the work merged at
this point.  I'm trying to get a feel for whether I should keep working on
this.

Thanks,
David Frey
